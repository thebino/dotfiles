-- A snazzy bufferline for Neovim 
return {
  {
    "romgrk/barbar.nvim",
    event = 'VimEnter',
    enabled = true,
    lazy = true,
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    init = function() 
        vim.g.barbar_auto_setup = false end,
        opts = {
            auto_hide = false,
            clickable = true,
            -- Enables / disables diagnostic symbols
            icons = {
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
                    [vim.diagnostic.severity.WARN] = {enabled = false},
                    [vim.diagnostic.severity.INFO] = {enabled = false},
                    [vim.diagnostic.severity.HINT] = {enabled = true},
                },
            },
            gitsigns = {
                added = {enabled = true, icon = '+'},
                changed = {enabled = true, icon = '~'},
                deleted = {enabled = true, icon = '-'},
            },
            modified = {button = '●'},
        },
    }
}

