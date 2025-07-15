return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- lazy load when opening files
        config = function()
            -- Example: Enable LSP for Lua (sumneko_lua) and Python (pyright)
            -- You can replace/extend servers as needed
            local lspconfig = require("lspconfig")
            -- Lua
            lspconfig.lua_ls.setup({})
            -- Python
            lspconfig.pyright.setup({})
            -- Rust
            -- see rust.lua
            -- lspconfig.rust_analyzer.setup({})
            -- Go
            lspconfig.gopls.setup({})
            -- Kotlin
            lspconfig.kotlin_language_server.setup({})
            -- TOML
            lspconfig.taplo.setup({})
            -- YAML
            lspconfig.yamlls.setup({})
            -- JSON
            lspconfig.jsonls.setup({})
            -- Terraform
            lspconfig.terraformls.setup({})
        end,
    }
}
