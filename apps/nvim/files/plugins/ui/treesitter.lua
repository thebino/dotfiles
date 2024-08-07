return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function()
      -- @see: https://github.com/nvim-orgmode/orgmode/issues/481
      local ok, orgmode = pcall(require, 'orgmode')
      if ok then orgmode.setup_ts_grammar() end

      require('nvim-treesitter.configs').setup({
        -- stylua: ignore
        ensure_installed = {
        	-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
          	'c', 'cpp', 'cmake', 'kconfig',
          	'kotlin', 'java', 'groovy',
          	'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'diff',
          	'go',
          	'html', 'css', 'json', 'ini',
          	'dockerfile',
          	'gpg', 'hurl', 'http', 'xml',
          	'vim', 'vimdoc', 'query', 'lua', 'luadoc', 'luap', 'regex', 
          	'markdown', 'markdown_inline',
            'rust'
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org', 'sql' },
        },
        incremental_selection = {
          enable = true,
          disable = { 'help' },
          keymaps = {
            init_selection = '<CR>', -- maps in normal mode to init the node/scope selection
            node_incremental = '<CR>', -- increment to the upper named parent
            node_decremental = '<C-CR>', -- decrement to the previous node
          },
        },
        indent = {
          enable = true,
          disable = { 'yaml' },
        },
        textobjects = {
          lookahead = true,
          select = {
            enable = true,
            include_surrounding_whitespace = true,
            keymaps = {
              ['af'] = { query = '@function.outer', desc = 'ts: all function' },
              ['if'] = { query = '@function.inner', desc = 'ts: inner function' },
              ['ac'] = { query = '@class.outer', desc = 'ts: all class' },
              ['ic'] = { query = '@class.inner', desc = 'ts: inner class' },
              ['aC'] = { query = '@conditional.outer', desc = 'ts: all conditional' },
              ['iC'] = { query = '@conditional.inner', desc = 'ts: inner conditional' },
              ['aL'] = { query = '@assignment.lhs', desc = 'ts: assignment lhs' },
              ['aR'] = { query = '@assignment.rhs', desc = 'ts: assignment rhs' },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { [']m'] = '@function.outer', [']M'] = '@class.outer' },
            goto_previous_start = { ['[m'] = '@function.outer', ['[M'] = '@class.outer' },
          },
        },
        autopairs = { enable = true },
        context_commentstring = { enable = true },
        playground = { persist_queries = true },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
      })
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'typescriptreact', 'javascript', 'javascriptreact', 'html', 'vue', 'svelte' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  },
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle' },
    dependencies = { 'nvim-treesitter' },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
      multiline_threshold = 4,
      separator = '─', -- alternatives: ▁ ─ ▄
      mode = 'cursor',
    },
  },
}
