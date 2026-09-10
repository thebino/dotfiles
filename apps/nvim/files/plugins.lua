-- plugins & dependencies (vim.pack resolves no deps)
vim.pack.add({
	-- parser generator: syntax highlighting and indentation
	"https://github.com/nvim-treesitter/nvim-treesitter",

	-- completion engine and its sources
	"https://github.com/hrsh7th/nvim-cmp", -- completion engine
	"https://github.com/hrsh7th/cmp-nvim-lsp", -- (dep)
	"https://github.com/lukas-reineke/cmp-rg", -- (dep)

	-- fuzzy finder over files, buffers, marks, grep and lsp results
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- (dep)

	-- file explorer sidebar
	"https://github.com/nvim-tree/nvim-tree.lua",

	-- git status in the sign column and in-line blame
	"https://github.com/lewis6991/gitsigns.nvim",

	-- one icon set for the file tree and the completion menu
	"https://github.com/echasnovski/mini.icons",

	-- rust: crate versions and actions inside Cargo.toml
	"https://github.com/saecki/crates.nvim",

	-- latex: compile, view and navigate documents
	"https://github.com/lervag/vimtex",

	-- runs external formatters on save, falls back to the language server
	"https://github.com/stevearc/conform.nvim",

	-- animated cursor with a smear effect
	"https://github.com/sphamba/smear-cursor.nvim",
}, { confirm = false }) -- install without the y/N prompt

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(ev)
		-- no-op for filetypes without an installed parser
		pcall(vim.treesitter.start, ev.buf)
	end,
})

require("nvim-treesitter")
	.install({
		-- "cpp",
		"dockerfile",
		"fsh",
		"helm",
		"json",
		"latex",
		"markdown",
		"regex",
		"rust",
		-- "sql",
		"ssh_config",
		"terraform",
		"toml",
		"yaml",
	})
	:wait(300000) -- blocks first run only; a no-op once parsers are installed

local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- vim.snippet is built in since 0.10, no snippet plugin needed
		expand = function(args)
			vim.snippet.expand(args.body)
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
			-- keeps cargo check off the shared Cargo.lock
			cargo = { targetDir = true },
			diagnostics = { disabled = { "macro-error" } },
		},
	},
})
vim.lsp.enable("rust_analyzer")

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
vim.keymap.set("n", "<leader>?", "<cmd>Telescope keymaps<cr>", { desc = "Search keymaps" })

require("nvim-tree").setup({
	hijack_directories = { enable = false },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File explorer" })

require("gitsigns").setup({
	-- everything else gitsigns already defaults to; blame is the one opt-in
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})

require("crates").setup({
	-- in-process language server; every one of these defaults to false
	lsp = {
		enabled = true,
		actions = true, -- codeActionProvider
		completion = true,
		hover = true,
	},
})

require("smear_cursor").setup({})

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
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 3000 },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })
