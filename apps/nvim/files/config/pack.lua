-- Helpers around the built-in plugin manager |vim.pack| (Neovim 0.12+).
--
-- Plugins live in `stdpath("data")/site/pack/core/opt`, their pinned revisions
-- in `~/.config/nvim/nvim-pack-lock.json`.
--   :lua vim.pack.update()          -- update all, review buffer, :w to confirm
--   :lua vim.pack.update({ "foo" }) -- update a single plugin
--   :lua vim.pack.del({ "foo" })    -- remove from disk
local M = {}

local function plug_dir()
    return vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt")
end

-- Remove directories that are not a working clone. `vim.pack` trusts whatever
-- it finds on disk, so a leftover from an interrupted install makes it either
-- run git inside that directory (`ENOENT (cwd)`) or clone over it ("already
-- exists and is not an empty directory") -- during the first `add()`, which
-- takes down the whole config.
-- A clone that was interrupted (Ctrl-C during the first install, a crash, a
-- full disk) leaves the directory behind with a `.git` that has no resolvable
-- HEAD -- git writes `ref: refs/heads/.invalid` until the checkout completes.
-- That is not a usable repository, but it looks like one from the outside.
local function is_usable_clone(dir)
    local git_dir = vim.fs.joinpath(dir, ".git")
    if vim.uv.fs_stat(git_dir) == nil then
        return false
    end

    local head_file = vim.fs.joinpath(git_dir, "HEAD")
    if vim.fn.filereadable(head_file) == 0 then
        return false
    end
    local head = (vim.fn.readfile(head_file)[1] or ""):gsub("%s+$", "")

    -- detached HEAD: a bare revision is enough
    if head:match("^%x%x%x%x%x%x%x%x") then
        return true
    end

    local ref = head:match("^ref:%s+(.+)$")
    if not ref then
        return false
    end
    if vim.uv.fs_stat(vim.fs.joinpath(git_dir, ref)) ~= nil then
        return true
    end

    -- the ref can also live in packed-refs
    local packed = vim.fs.joinpath(git_dir, "packed-refs")
    if vim.fn.filereadable(packed) == 1 then
        for _, line in ipairs(vim.fn.readfile(packed)) do
            if line:find(ref, 1, true) then
                return true
            end
        end
    end
    return false
end

local function prune_broken_installs()
    local opt = plug_dir()
    local removed = {}
    if vim.uv.fs_stat(opt) == nil then
        return removed
    end
    for name, fs_type in vim.fs.dir(opt) do
        local dir = vim.fs.joinpath(opt, name)
        if fs_type ~= "directory" or not is_usable_clone(dir) then
            vim.fs.rm(dir, { recursive = true, force = true })
            removed[#removed + 1] = name
        end
    end
    return removed
end

-- Drop lock entries that describe neither a plugin on disk nor a usable
-- revision, so `vim.pack` reinstalls them instead of trying to repair them.
local function prune_lockfile(removed)
    local path = vim.fs.joinpath(vim.fn.stdpath("config"), "nvim-pack-lock.json")
    if vim.fn.filereadable(path) == 0 then
        return removed
    end
    local ok, lock = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
    if not ok or type(lock) ~= "table" or type(lock.plugins) ~= "table" then
        return removed
    end

    local opt, dropped = plug_dir(), false
    for name, data in pairs(lock.plugins) do
        local on_disk = vim.uv.fs_stat(vim.fs.joinpath(opt, name)) ~= nil
        local bad_data = type(data) ~= "table" or type(data.rev) ~= "string" or type(data.src) ~= "string"
        if not on_disk and bad_data then
            lock.plugins[name] = nil
            dropped = true
            if not vim.tbl_contains(removed, name) then
                removed[#removed + 1] = name
            end
        end
    end

    if dropped then
        if vim.tbl_isempty(lock.plugins) then
            vim.fn.delete(path)
        else
            vim.fn.writefile(vim.split(vim.json.encode(lock), "\n"), path)
        end
    end
    return removed
end

local cleaned = prune_lockfile(prune_broken_installs())
if #cleaned > 0 then
    -- deferred so it lands after startup, where it is actually readable
    vim.schedule(function()
        vim.notify(
            "pack: cleaned up incomplete install of " .. table.concat(cleaned, ", "),
            vim.log.levels.WARN
        )
    end)
end

--- Install and load plugins.
--- Wraps |vim.pack.add()| without the initial install confirmation prompt, so
--- a fresh machine can be provisioned headlessly.
---
--- A clone that fails (rate limit, dropped connection) leaves partial state
--- behind, and every later step over it fails too: `ENOENT (cwd)` while git
--- runs in the missing directory, then `E919: Directory not found in
--- \'packpath\'` when the plugin is `:packadd`ed. Clean up and retry once,
--- which turns a transient network error into a slower startup instead of a
--- module that does not load.
--- @param specs (string|table)[]
function M.add(specs)
    local ok, err = pcall(vim.pack.add, specs, { confirm = false })
    if ok then
        return
    end

    prune_lockfile(prune_broken_installs())
    local retried, retry_err = pcall(vim.pack.add, specs, { confirm = false })
    if not retried then
        error(("%s (retry after %s)"):format(retry_err, err), 0)
    end
end

return M
