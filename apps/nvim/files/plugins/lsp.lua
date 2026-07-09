return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        event = { "BufReadPre", "BufNewFile" }, -- lazy load when opening files
        config = function()
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_lsp.default_capabilities()

            -- This is using the new LSP Core API (Neovim 0.11+)
            -- https://neovim.io/doc/user/lsp.html#lsp-quickstart
            vim.lsp.config('rust_analyzer', {
                cmd = { "rust-analyzer" },
                filetypes = { "rust" },
                root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.toml", ".git" }, { upward = true })[1] or vim.loop.cwd()),
                capabilities = capabilities,
                settings = {
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
            })
            vim.lsp.enable('rust_analyzer')

            -- Optional: attach LSP keymaps automatically to any client
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buf = args.buf
                    local opts = { buffer = buf, remap = false }

                    -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)


                    -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", opts)

                    vim.keymap.set("n", "<leader>gD", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "<leader>gD", "<cmd>Telescope diagnostics<cr>", opts)

                    vim.keymap.set("n", "<leader>gk", vim.lsp.buf.hover, { desc = "Code hover" })
                    vim.keymap.set("n", "<leader>gg", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                end,
            })
        end
    }
}
