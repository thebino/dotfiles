return {
{
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      goimports = "goimports", -- goimport command
      gofmt = "gofumpt",      --gofmt cmd,
      --max_line_len = 80,      -- max line length in goline format
      tag_transform = false,  -- tag_transfer  check gomodifytags for details
      verbose = true,         -- output loginf in messages
      log_path = vim.fn.expand("$HOME") .. "/gonvim.log",
      lsp_cfg = {
          capabilities = capabilities,
          settings = {
              gopls = {
                  analyses = {
                      ST1003 = false,
                  },
              },
          },
      },                         -- true: apply go.nvim non-default gopls setup
      lsp_gofumpt = true,        -- true: set default gofmt in gopls format to gofumpt
      lsp_on_attach = on_attach, -- if a on_attach function provided:  attach on_attach function to gopls
      -- true: will use go.nvim on_attach if true
      -- nil/false do nothing

      lsp_codelens = true,
      -- gopls_remote_auto = true, -- set to false is you do not want to pass -remote=auto to gopls(enable share)
      -- gopls_cmd = nil,
      -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
      diagnostic = {   -- set diagnostic to false to disable vim.diagnostic setup
          hdlr = true, -- hook lsp diag handler
          underline = true,
          -- virtual text setup
          virtual_text = { space = 0, prefix = '■' },
          signs = true,
          update_in_insert = false,
      },
      lsp_inlay_hints = {
          enable = true,
      },
      build_tags = "unit,integration",
      test_runner = "richgo",  -- richgo, go test, richgo, dlv, ginkgo
      verbose_tests = true,    -- set to add verbose flag to tests
      run_in_floaterm = true,  -- set to true to run in float window.
    })
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
}
