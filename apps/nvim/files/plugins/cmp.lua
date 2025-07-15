return {
    {
        "hrsh7th/nvim-cmp",
        event = { "CmdlineEnter", "InsertEnter" }, -- lazy load on entering insert mode
        enabled = true,
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "lukas-reineke/cmp-rg",
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",
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
                sources = {
                    -- keyword_length = 2 // MAX length of inp8t
                    { name = "nvim_lsp", priority = 1, priority_weight = 3 }, -- hrsh7th/nvim-cmp
                    -- { name = "buffer",   keyword_length = 2, priority_weight = 2 }, -- hrsh7th/cmp-buffer  for buffer words
                    -- { name = "luasnip",  keyword_length = 2, priority_weight = 1, option = { show_autosnippets = false } },
                    -- { name = "neorg", ft = "norg" },
                    -- { name = "copilot.lua", max_item_count = 2 },
                    -- { name = "path", keyword_length = 2 }, -- hrsh7th/cmp-path   paths of files and folders
                    -- { name = "rg", keyword_length = 3 }, -- lukas-reineke/cmp-rg   ripgrep results
                },
            })
        end,
    }
}

