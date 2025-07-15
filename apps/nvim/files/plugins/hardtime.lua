return {
    {
        "m4xshen/hardtime.nvim",
        event = 'VimEnter',
        enabled = true,
        lazy = true,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            disable_mouse = false,
            disabled_keys = {
                ["<Up>"] = {},
                ["<Down>"] = {},
                ["<Left>"] = {},
                ["<Right>"] = {},
            },
            hints = {
            }
        }
    }
}
