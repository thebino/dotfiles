-- A snazzy bufferline for Neovim 
return {
  {
    "nanozuki/tabby.nvim",
    event = 'VimEnter',
    enabled = true,
    lazy = true,
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      icons_enabled = true,
    },
    -- config = funcion(),
      -- configs...
    -- end,
  }
}
