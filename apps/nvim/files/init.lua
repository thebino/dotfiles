-- Install lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Unicode has variants of the same glyph in multiple tables. Early pictographic symbols are an example
-- of them being duplicated in the emoji list. (think: b&w smiley face vs full-color version.) Appending
-- this codepoint will cause the previous character to always be selected from the emoji table.
local force_emoji = '\u{FE0F}'

-- require("config.abbreviations")
require("config.autocmds")
require("config.keymaps")
require("config.options")

if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true, { 0 })
end

require("lazy").setup({
    spec = "plugins",
    defaults = { lazy = true },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    performance = {
        rtp = {
            paths = { "/usr/lib/nvim" },
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            }
        },
    },
    ui = {
        icons = {
            cmd = "⌘" .. force_emoji,
            config = "🛠" .. force_emoji,
            event = "📅",
            ft = "📂",
            init = "⚙" .. force_emoji,
            keys = "🗝" .. force_emoji,
            plugin = "🔌",
            runtime = "💻" .. force_emoji,
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
        border = "rounded",
    }
})
