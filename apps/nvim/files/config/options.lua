local opt = vim.opt -- for conciseness

-- don't create swapfiles
opt.swapfile = false


-- line numbers
opt.relativenumber = false -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)


-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- convert tab to spaces
opt.autoindent = true -- re-use indentation from previous line


-- line wrapping
opt.wrap = false

-- folding
opt.foldmethod = "indent" -- fold code by indentation
opt.foldlevelstart = 4 -- code with an indentation higher than $1 are closed by default

-- search settings
opt.ignorecase = true -- case-insensitive search
opt.smartcase = true -- use case-sensitive when camelCase search query
opt.hlsearch = false -- disable highlighing during search

-- cursor line
opt.cursorline = true -- highlight current line


-- appearance
opt.termguicolors = true -- use full colors
opt.background = "dark"
opt.signcolumn = "yes" -- Keep sign column on
opt.showmode = false -- Dont show mode since we have a statusline
opt.laststatus = 3 -- global statusline instead of a statusline per window


-- clipboard
opt.clipboard = 'unnamedplus'   -- use system clipboard 


-- windows
opt.splitright = true -- split vertical
opt.splitbelow = true -- split horizontal


-- save undo history
opt.undofile = true
opt.undolevels = 10000


-- additionals
opt.iskeyword:append("-") -- consider "string-string" as whole word
opt.confirm = true -- Confirm to save changes before exiting modified buffer

