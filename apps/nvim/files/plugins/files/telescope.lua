return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = { "VeryLazy" },
    enabled = true,
    lazy = true,
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "File Grep" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
        vim.keymap.set('n', '<leader>ft', "<CMD>:Neotest summary<cr>", { desc = "Neotest summary" })
        vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = "Goto definition" })
        vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = "Goto reference" })
    end,
  }
}

