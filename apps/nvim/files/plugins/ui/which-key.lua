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
          { "<leader>f", group = "File" }, -- group
          { "<leader>d", group = "Debug" }, -- group
          { "<leader>l", group = "Git" }, -- group
          { "<leader>g", group = "Code" }, -- group
          { "<leader>c", group = "Diagnostics" }, -- group
          { "<leader>b", group = "Buffers" }, -- group
          { "<leader>q", group = "Quit" }, -- group
          { "<leader>w", group = "Window" }, -- group
          { "<leader>u", group = "Ui" }, -- group
        })
    end, 
    enabled = true,
    lazy = false,
  },
}

