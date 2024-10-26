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
          { "<leader>l", group = "Latex" }, -- group
          { "<leader>g", group = "Goto" }, -- group
          { "<leader>e", group = "Error Diagnostics" }, -- group
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

