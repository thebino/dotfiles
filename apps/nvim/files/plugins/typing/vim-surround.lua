-- all about "surroundings": parentheses, brackets, quotes, XML tags, and more
return {
  {
    "tpope/vim-surround",
    enabled = true,
    lazy = false,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  }
}

