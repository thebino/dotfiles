-- LSP Diagnostics Options Setup 
return {
  {
    "yamatsum/nvim-cursorline",
    enabled = true,
    lazy = false,
    opts = function()
      return {
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  },
  {
    "mawkler/modicator.nvim",
    dependencies = "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {}
  }
}
