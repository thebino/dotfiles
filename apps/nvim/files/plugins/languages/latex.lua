return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            -- Use init for configuration, don't use the more common "config".
            vim.g.vimtex_view_method = "sioyek"
            vim.g.vimtex_compiler_progname = "latexmk"
        end,
        keys = {
            { "<leader>ll", "<cmd>VimtexCompile<CR>", desc = "Start continuous compilation" },
            { "<leader>lx", "<cmd>VimtexStop<CR>", desc = "Stop continuous compilation" },
            { "<leader>lv", "<cmd>VimtexView<CR>", desc = "View latex" },
            { "<leader>lt", "<cmd>VimtexTocToggle<CR>", desc = "TOC latex" },
            { "<leader>ls", "<cmd>VimtexStatus<CR>", desc = "Show latex status" },
        },
    }
}

