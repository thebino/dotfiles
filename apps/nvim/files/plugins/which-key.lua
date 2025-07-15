return {
    {
        "folke/which-key.nvim",
        dependencies = 'echasnovski/mini.icons',
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.add({
                -- https://www.nerdfonts.com/cheat-sheet
                { "<leader>a", group = "Code actions", icon = "" },
                { "<leader>b", group = "Buffers", icon = "󰪶" },
                -- { "<leader>e", group = "Error Diagnostics", icon = "" },
                { "<leader>j", group = "JWT Token", icon = "󰯅" },
                { "<leader>f", group = "File", icon = "" },
                { "<leader>d", group = "Debug", icon = "" },
                { "<leader>l", group = "Latex", icon = "" },
                { "<leader>g", group = "Goto", icon = "󱣱" },
                { "<leader>q", group = "Quit", icon = "󰩈" },
                { "<leader>w", group = "Window", icon = "" },
                { "<leader>u", group = "Ui", icon = "󱥈" },
                { "<leader>s", group = "Snippets", icon = "" },
                { "<leader>t", group = "Testing", icon = "󰱑" },
            })
        end, 
        enabled = true,
        lazy = false,
    },
}

