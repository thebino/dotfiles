return {
    {
        "mrcjkb/rustaceanvim",
        dependencies = {  -- optional packages
            "nvim-neotest/neotest",
        },
        version = '^5',
        init = function()
            -- Configure rustaceanvim here
            vim.g.rustaceanvim = {
                require("neotest").setup({
                    adapters = {
                        require("rustaceanvim.neotest"),
                    },
                }),
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
        keys = {
            { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
            { "<leader>t", "<cmd>lua vim.cmd.RustLsp('testables')<CR>", desc = "Rust test" },
        },
        lazy = false,
    },
    {
        "saecki/crates.nvim",
        tag = 'stable',
        requires = { 'nvim-lua/plenary.nvim' },
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup {
                -- auto completion and code actions
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            }
        end
    }
}

