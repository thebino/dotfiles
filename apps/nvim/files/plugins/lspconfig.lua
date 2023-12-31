-- LSP Diagnostics Options Setup 
return {
  {
    "williamboman/mason-lspconfig.nvim",
    event = { 'BufReadPre', 'BufNewFile' },
    enabled = true,
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = { ui = { border = border, height = 0.8 } },
      },
      {
        "neovim/nvim-lspconfig",
        config = function()
        end,
      }
    },
    opts = {
      automatic_installation = true,
      handlers = {
        function(name)
          local config = require('as.servers')(name)
          if config then require('lspconfig')[name].setup(config) end
        end
      },
    },   
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(name, opts)
      require'lsp_signature'.setup(opts) 
    end
  }
}
