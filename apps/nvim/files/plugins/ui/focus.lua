return {
  {
    "folke/twilight.nvim",
    event = 'VimEnter',
    enabled = true,
    lazy = true,
    opts = {
      plugins = {
        gitsigns = true,
      },
      context = 15,
      treesitter = true, -- use treesitter when available for the filetype
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        -- markdown
        "paragraph", 
        "fenced_code_block", 
        "list",
        "decorated_definition",
        "constructor_definition",
        "function_definition",
        "function_declaration",
        "table_constructor",
        "for_statement",
        "if_statement",
      },
    }
  }
}

