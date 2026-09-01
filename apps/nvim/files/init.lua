-- Plugins are managed by the built-in package manager `vim.pack` (Neovim 0.12+).
-- `lua/plugins.lua` declares every plugin in a single `vim.pack.add()` call and
-- configures them right away; there is no lazy loading.
-- See `lua/config/pack.lua` for update/remove commands.

-- system-wide plugins (linux packaging puts runtime files here)
if vim.uv.fs_stat("/usr/lib/nvim") then
    vim.opt.rtp:append("/usr/lib/nvim")
end

-- disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

-- must come before any `vim.pack.add()` so build hooks fire on first install
require("config.pack")

-- require("config.abbreviations")
require("config.autocmds")
require("config.keymaps")
require("config.options")

if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { 0 })
end

-- every plugin and its configuration lives in `lua/plugins.lua`
local ok, err = pcall(require, "plugins")
if not ok then
    -- reported after startup: notifications raised while the config is still
    -- being sourced scroll past before the UI can show them
    vim.schedule(function()
        vim.notify("failed to load plugins: " .. err, vim.log.levels.ERROR)
    end)
end
