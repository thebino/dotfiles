return {
{
    "mrcjkb/rustaceanvim",
    version = '^4',
    init = function()
      -- Configure rustaceanvim here
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
            autoSetHints = true,
            inlay_hints = {
              show_parameter_hints = true,
              parameter_hints_prefix = "<- ",
              other_hints_prefix = "=> ",
            },
        },
        -- LSP configuration
        server = {
            on_attach = on_attach,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = {
                    cargo = {
                        allFeatures = true,
                    },
                    diagnostics = {
                        disabled = { "macro-error" },
                    },
                    procMacro = {
                        enable = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                    inlayHints = {
                        enable = true,
                        showParameterNames = true,
                        parameterHintsPrefix = "<- ",
                        otherHintsPrefix = "=> ",
                    },
                },
            },
        },
      }
    end,
    lazy = false,
}
}

