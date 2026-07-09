return {
    {
        "hrsh7th/nvim-cmp",
        event = { "CmdlineEnter", "InsertEnter" }, -- lazy load on entering insert mode
        enabled = true,
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- src: built-in lsp
            "hrsh7th/cmp-buffer",   -- src: buffer words
            "hrsh7th/cmp-path",     -- src: paths of files and folders

            'L3MON4D3/LuaSnip', -- snippet engine
            'saadparwaiz1/cmp_luasnip', -- snippet source for cmp
            "rafamadriz/friendly-snippets", -- Snippets collection

            -- "hrsh7th/cmp-path",
            "lukas-reineke/cmp-rg", -- src: ripgrep

            "onsails/lspkind.nvim", -- adds icons to completions
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            -- Load friendly snippets
            require("luasnip.loaders.from_vscode").lazy_load()
            -- Load ~/.config/nvim/snippets/
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" },
            })


            luasnip.config.setup({
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                performance = {
                    debounce = 0, -- default is 60ms
                    throttle = 0, -- default is 30ms
                },
                sorting = {
                    priority_weight = 2.0,  -- Global source order boost
                },
                mapping = cmp.mapping.preset.insert({
                    -- Tab selects next completion item
                    ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
                    -- Shift + Tab selects previous item
                    ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },

                    -- Enter key confirms completion item
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }),
                sources = {
                    { name = "luasnip",  keyword_length = 1, priority_weight = 10, option = { show_autosnippets = true } }, -- L3MON4D3/LuaSnip  &  saadparwaiz1/cmp_luasnip
                    { name = "nvim_lsp", priority_weight = 4 }, -- hrsh7th/nvim-cmp
                    { name = "rg", keyword_length = 5, priority_weight = 1}, -- lukas-reineke/cmp-rg
                    -- { name = "buffer",   keyword_length = 2, priority_weight = 1 }, -- hrsh7th/cmp-buffer
                    -- { name = "path", keyword_length = 2, priority_weight = 1 }, -- hrsh7th/cmp-path
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',  -- Icons + text
                        maxwidth = 50,
                    }),
                },
            })
        end,
    }
}

