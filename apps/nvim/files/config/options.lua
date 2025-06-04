vim.opt.swapfile = false -- don't create swapfiles

-- line numbers
vim.opt.relativenumber = false -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tab to spaces
vim.opt.autoindent = true -- re-use indentation from previous line

vim.opt.wrap = false -- line wrapping

-- folding
vim.opt.foldmethod = "indent" -- fold code by indentation
vim.opt.foldlevelstart = 8 -- code with an indentation higher than $1 are closed by default

-- search settings
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- use case-sensitive when camelCase search query
vim.opt.hlsearch = false -- disable highlighing during search

-- cursor line
vim.opt.cursorline = true -- highlight current line

-- appearance
vim.opt.termguicolors = true -- use full colors
vim.opt.background = "dark"
vim.opt.signcolumn = "yes" -- Keep sign column on
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.laststatus = 3 -- global statusline instead of a statusline per window

-- clipboard
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 

-- windows
vim.opt.splitright = true -- split vertical
vim.opt.splitbelow = true -- split horizontal

-- save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- additionals
vim.opt.iskeyword:append("-") -- consider "string-string" as whole word
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

