-- Auto completion
return {
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
            'benfowler/telescope-luasnip.nvim',
        },
        config = function() 
            -- load friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            -- load custom snippets
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
            require("luasnip").config.setup({ store_selection_keys = "<Tab>" })
        end,
        keys = {
            { "<c-k>", mode = { "i", "s" }, function() require("luasnip").jump( 1) end, { silent = true} },
            { "<c-j>", mode = { "i", "s" }, function() require("luasnip").jump( -1) end, { silent = true} },
        },
        after = 'nvim-cmp',
    },
    {
        "benfowler/telescope-luasnip.nvim",
        after = 'nvim-telescope/telescope.nvim',
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "L3MON4D3/LuaSnip",
        },
        keys = {
            { "<leader>s", "<cmd>Telescope luasnip<cr>", desc = "Snippets" }
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "CmdlineEnter", "InsertEnter" },  
        enabled = true,
        lazy = true,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "lukas-reineke/cmp-rg",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            performance = {
                debounce = 0, -- default is 60ms
                throttle = 0, -- default is 30ms
            },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- Tab selects next completion item
                    ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                    -- Shift + Tab selects previous item
                    ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },

                    -- Enter key confirms completion item
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl + space triggers completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Ctrl + d/f scrolls through documentation
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "abbr", "kind", "menu" },
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        preset = "codicons",
                        maxwidth = 50,
                        ellipsis_char = "…",
                        menu = {
                            buffer = "[Buf]", -- buffer
                            cmdline = "[Cmd]", -- command line suggestions
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            neorg = "[Norg]",
                            -- copilot = "[GHC]",
                            path = "[Path]", -- Filesystem path
                            rg = "[RG]", -- RipGrep results
                        },
                    }),
                },
                matching = { disallow_prefix_unmatching = true },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip", option = { show_autosnippets = true } },
                    { name = "neorg", ft = "norg" },
                    -- { name = "buffer", keyword_length = 2 },
                    -- { name = "copilot", max_item_count = 2 },
                    { name = "path", keyword_length = 2 },
                    { name = "rg", keyword_length = 3 },
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })
        end,
    }
}

