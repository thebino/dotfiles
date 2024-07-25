-- motion plugin
return {
  {
    "ggandor/leap.nvim",
    enabled = true,
    lazy = false,
    keys = {'s'} ,
    config = function()
        vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
          local current_window = vim.fn.win_getid()
          require('leap').leap({ target_windows = { current_window } })
        end, { noremap = true})
    end,
  }
}
