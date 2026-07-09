return {
    {
        "nvim-telescope/telescope.nvim", tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Open Buffers" },
            { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Previously open files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader><space>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>gl", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
            { "<leader>m", "<cmd>Telescope marks<cr>", desc = "Show marks" },
        },
        config = function()
            require("telescope").setup({
                pickers = {
                    marks = {
                        attach_mappings = function(prompt_bufnr, map)
                            local actions = require("telescope.actions")
                            local delete_mark = actions.delete_mark
                            map({ "i", "n" }, "<C-d>", delete_mark)
                            return true  -- Keep other mappings
                        end,
                    },
                },
            })
        end
    }
}
