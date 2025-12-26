-- Set rustaceanvim global config early (before plugin load)
vim.g.rustaceanvim = {
    tools = {
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
        },
    },
    server = {
        on_attach = function(client, bufnr)
            -- Basic LSP keymaps
            local opts = { buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
        default_settings = {
            ["rust-analyzer"] = {
                cargo = { targetDir = true, allFeatures = true },
                diagnostics = { disabled = { "macro-error" } },
                procMacro = { enable = true },
                checkOnSave = true,
                check = {
                    allTargets = true,
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

return {
    {
        "mrcjkb/rustaceanvim",
        version = '^6',
        event = { "BufReadPre *.rs" },
        lazy = false,
        dependencies = {
            "nvim-neotest/neotest",
        },
        keys = {
            { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" },
            { "<leader>gR", "<cmd>lua vim.cmd.RustLsp('expandMacro')<CR>", desc = "Expand Macro" },
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("rustaceanvim.neotest"),
                },
            }
        end,
        keys = {
            { "<leader>t", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run nearest test" },
            -- { "<leader>ta", "<cmd>lua require('neotest').run.attach()<CR>", desc = "Attach to test" },
        },
    },
    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            }
        end,
    },
}
