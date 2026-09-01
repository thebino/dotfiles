-- Every plugin this config uses, installed by the built-in |vim.pack|.
-- See `lua/config/pack.lua` for the update/remove commands and the cleanup
-- that runs before the first install.

local pack = require("config.pack")

-- vimtex is configured through global variables, which have to be set before
-- its `plugin/` files are sourced (which happens right after `init.lua`).
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_compiler_progname = "latexmk"

-- One `add()` call means one install batch: everything clones in parallel and
-- the progress counter runs 1..n once, instead of restarting per module.
pack.add({
	-- colorscheme
	"https://github.com/folke/tokyonight.nvim",

	-- parser generator: syntax highlighting and indentation
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- completion engine, its sources and the snippet engine behind them
	"https://github.com/hrsh7th/nvim-cmp", -- completion engine
	"https://github.com/hrsh7th/cmp-nvim-lsp", -- (dep) cmp source: lsp + client capabilities
	"https://github.com/lukas-reineke/cmp-rg", -- (dep) cmp source: ripgrep
	"https://github.com/L3MON4D3/LuaSnip", -- snippet engine, loads ~/.config/nvim/snippets
	"https://github.com/saadparwaiz1/cmp_luasnip", -- (dep) cmp source: LuaSnip
	"https://github.com/rafamadriz/friendly-snippets", -- (dep) community snippet collection for LuaSnip

	-- fuzzy finder over files, buffers, marks, grep and lsp results
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- (dep) lua stdlib, also used by crates.nvim

	-- file explorer sidebar
	"https://github.com/nvim-tree/nvim-tree.lua",

	-- git status in the sign column and in-line blame
	"https://github.com/lewis6991/gitsigns.nvim",

	-- pop-up listing the mappings behind a prefix key
	"https://github.com/folke/which-key.nvim",

	-- one icon set for which-key, the file tree and the completion menu
	"https://github.com/echasnovski/mini.icons",

	-- rust: crate versions and actions inside Cargo.toml
	"https://github.com/saecki/crates.nvim",

	-- latex: compile, view and navigate documents
	"https://github.com/lervag/vimtex",

	-- runs external formatters on save, falls back to the language server
	"https://github.com/stevearc/conform.nvim",
})

-- ---------------------------------------------------------------- colorscheme
vim.cmd.colorscheme("tokyonight-night")

-- ---------------------------------------------------------------------- icons
require("mini.icons").setup()
-- answers as `nvim-web-devicons` so nvim-tree finds the icons it asks for
MiniIcons.mock_nvim_web_devicons()

-- ----------------------------------------------------------------- treesitter
-- nvim-treesitter `main` only installs parsers, starting them is up to us
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(ev)
		-- no-op for filetypes without an installed parser
		pcall(vim.treesitter.start, ev.buf)
	end,
})

require("nvim-treesitter")
	.install({
		"arduino",
		"c",
		"cpp",
		"dockerfile",
		"fsh",
		"helm",
		"json",
		"latex",
		"lua",
		"markdown",
		"regex",
		"rust",
		"sql",
		"ssh_config",
		"terraform",
		"toml",
		"yaml",
	})
	:wait(300000) -- wait max. 5 minutes

-- parsers compiled just now are invisible to the cached runtime path scan,
-- which would leave the first session after an install without highlighting
vim.o.runtimepath = vim.o.runtimepath

-- ----------------------------------------------------------------- completion
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- Load ~/.config/nvim/snippets/
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { vim.fn.stdpath("config") .. "/snippets" },
})

luasnip.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	performance = {
		debounce = 0, -- default is 60ms
		throttle = 0, -- default is 30ms
	},
	sorting = {
		priority_weight = 2.0, -- Global source order boost
	},
	mapping = cmp.mapping.preset.insert({
		-- Tab selects next completion item
		["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		-- Shift + Tab selects previous item
		["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		-- Enter key confirms completion item
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = {
		{ name = "luasnip", keyword_length = 1, priority_weight = 10, option = { show_autosnippets = true } }, -- L3MON4D3/LuaSnip  &  saadparwaiz1/cmp_luasnip
		{ name = "nvim_lsp", priority_weight = 4 }, -- hrsh7th/nvim-cmp
		{ name = "rg", keyword_length = 5, priority_weight = 1 }, -- lukas-reineke/cmp-rg
	},
	formatting = {
		-- icon + kind name, entry text capped at 50 columns
		format = function(_, item)
			item.kind = MiniIcons.get("lsp", item.kind) .. " " .. item.kind
			if #item.abbr > 50 then
				item.abbr = item.abbr:sub(1, 49) .. "…"
			end
			return item
		end,
	},
})

-- ------------------------------------------------------------------------ lsp
-- No nvim-lspconfig: the server below is configured by hand, and everything
-- needed for that is core since neovim 0.11 (|vim.lsp.config|).
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- `rust-analyzer` on $PATH is a rustup shim resolving against the *default*
-- toolchain. With a custom default (like `esp`) it exits with "not installed
-- for the custom toolchain", the server never attaches, and every LspAttach
-- mapping silently goes missing. Use the stable toolchain's binary directly.
local function rust_analyzer_cmd()
	local stable =
		vim.fn.glob(vim.fs.joinpath(vim.env.HOME, ".rustup/toolchains/stable-*/bin/rust-analyzer"), false, true)
	return #stable > 0 and { stable[1] } or { "rust-analyzer" }
end

vim.lsp.config("rust_analyzer", {
	cmd = rust_analyzer_cmd(),
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = { targetDir = true, allFeatures = true },
			diagnostics = { disabled = { "macro-error" } },
			procMacro = { enable = true },
			checkOnSave = true,
			check = {
				allTargets = true,
			},
			inlayHints = {
				enable = true,
				showParameterNames = true,
				parameterHintsPrefix = "<- ",
				otherHintsPrefix = "=> ",
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf, remap = false }

		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>gd",
		-- 	"<cmd>Telescope lsp_definitions<cr>",
		-- 	vim.tbl_extend("force", opts, { desc = "Goto definition" })
		-- )
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>grr",
		-- 	"<cmd>Telescope lsp_references<cr>",
		-- 	vim.tbl_extend("force", opts, { desc = "Goto references" })
		-- )
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>gD",
		-- 	"<cmd>Telescope diagnostics<cr>",
		-- 	vim.tbl_extend("force", opts, { desc = "Diagnostics" })
		-- )
		-- vim.keymap.set("n", "<leader>gk", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Code hover" }))
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>gg",
		-- 	vim.lsp.buf.rename,
		-- 	vim.tbl_extend("force", opts, { desc = "Rename reference" })
		-- )
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>a",
		-- 	vim.lsp.buf.code_action,
		-- 	vim.tbl_extend("force", opts, { desc = "Code action" })
		-- )
	end,
})

-- --------------------------------------------------------------------- finder
require("telescope").setup({
	pickers = {
		marks = {
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("telescope.actions")
				map({ "i", "n" }, "<C-d>", actions.delete_mark)
				return true -- Keep other mappings
			end,
		},
	},
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Open Buffers" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Previously open files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>gl", "<cmd>Telescope git_files<cr>", { desc = "Git Files" })
vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks<cr>", { desc = "Show marks" })

-- --------------------------------------------------------------- file browser
-- change color for arrows in tree to light blue
vim.cmd.highlight("NvimTreeFolderArrowClosed guifg=#3FC5FF")
vim.cmd.highlight("NvimTreeFolderArrowOpen guifg=#3FC5FF")

require("nvim-tree").setup({
	view = {
		number = true,
		relativenumber = true,
		signcolumn = "auto",
		width = {
			min = 40,
		},
	},
	renderer = {
		highlight_git = "all",
		highlight_opened_files = "name",
		highlight_diagnostics = "name",
		hidden_display = "all",
		icons = {
			git_placement = "signcolumn",
			bookmarks_placement = "before",
			symlink_arrow = " -> ",
			show = {
				folder = false,
				folder_arrow = false,
			},
			glyphs = {
				git = {
					unstaged = "×",
					staged = "",
					unmerged = "󰧾",
					untracked = "",
					renamed = "",
					deleted = "",
					ignored = "∅",
				},
			},
		},
		indent_markers = {
			enable = true,
		},
	},
	hijack_directories = { enable = false },
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
	},
	modified = {
		enable = true,
	},
	ui = {
		confirm = {
			default_yes = true,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File explorer" })

-- ------------------------------------------------------------------ git signs
require("gitsigns").setup({
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})

-- ------------------------------------------------------------------ which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").add({
	-- https://www.nerdfonts.com/cheat-sheet
	{ "<leader>b", group = "Buffer", icon = "󰕸" },
	{ "<leader>f", group = "File", icon = "󰈔" },
	{ "<leader>l", group = "Latex (use ,l)", icon = "" },
	{ "<leader>c", group = "Code", icon = "󰅩" },
	{ "<leader>g", group = "Goto", icon = "󱣱" },
	{ "<leader>q", group = "Quit", icon = "󰩈" },
	{ "<leader>w", group = "Window", icon = "" },
	{ "<leader> ", group = "Grep", icon = "󱝩" },
	-- { "<leader>u", group = "Ui", icon = "󱥈" },
	-- { "<leader>s", group = "Snippets", icon = "" },
	-- { "<leader>t", group = "Testing", icon = "󰱑" },
})

-- ----------------------------------------------------------------------- rust
-- crates.nvim attaches itself to Cargo.toml buffers
require("crates").setup({
	lsp = {
		enabled = true,
		actions = true,
		completion = true,
		hover = true,
	},
})

-- ---------------------------------------------------------------------- latex
-- vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "Start continuous compilation" })
-- vim.keymap.set("n", "<leader>lx", "<cmd>VimtexStop<CR>", { desc = "Stop continuous compilation" })
-- vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View latex" })
-- vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "TOC latex" })
-- vim.keymap.set("n", "<leader>ls", "<cmd>VimtexStatus<CR>", { desc = "Show latex status" })

-- ----------------------------------------------------------------- formatting
require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		lua = { "stylua" },
		json = { "jq" },
		toml = { "taplo" },
		tex = { "latexindent" },
		yaml = { "yamlfmt" },
	},
	-- fall back to the language server when no formatter above is installed
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = function(bufnr)
		if vim.b[bufnr].autoformat == false or vim.g.autoformat == false then
			return
		end
		return { timeout_ms = 3000 }
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>uf", function()
	vim.g.autoformat = vim.g.autoformat == false
	vim.notify("format on save " .. (vim.g.autoformat == false and "off" or "on"))
end, { desc = "Toggle format on save" })
