return require("packer").startup(function(use)
    -- Packer | Plugin manager
    use("wbthomason/packer.nvim")


    -- Colorschema
    use("EdenEast/nightfox.nvim")


    -- Icons
    use("nvim-tree/nvim-web-devicons")


    -- Statusline
    use({
        "nvim-lualine/lualine.nvim",
        event = "BufEnter",
        config = function()
            require("thebino.plugins.lualine")
        end,
        requires = { "nvim-web-devicons" },
    })


    -- File manager
    use({
        "nvim-neo-tree/neo-tree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    })


    -- Rust Tools
    use({
        "simrat39/rust-tools.nvim",
        config = function()
            require("thebino.plugins.rust-tools")
        end,
    })


    -- LSP Config
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("thebino.plugins.nvim-lspconfig")
        end,
    })


    -- Completion framework:
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("thebino.plugins.nvim-cmp")
        end,
    })

    -- LSP completion source:
    use("hrsh7th/cmp-nvim-lsp")

    -- Useful completion sources:
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/vim-vsnip")


    -- Treesitter (Code parsing & highlighting)
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("thebino.plugins.nvim-treesitter")
        end,
    })


    -- Telescope (Fuzzy finder - Find, Filter, Preview)
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("thebino.plugins.telescope")
        end,
    })


    -- Git line blame
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("thebino.plugins.gitsigns")
        end,
    })



    -- Graphical debugger
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("thebino.plugins.nvim-dap").setup()
        end,
        dependencies = {
          "rcarriga/nvim-dap-ui",
          "williamboman/mason-lspconfig.nvim",
        },
    })

    use({
        "rcarriga/nvim-dap-ui",
        config = function()
          require("thebino.plugins.nvim-dap").setup_ui()
        end,
    })
end)
