-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- unbind space so that <leader><p> does not shift your paste
vim.keymap.set({ "n", "x" }, " ", "<nop>")

-- pretty format json file
vim.keymap.set("n", "<leader>gp", "<cmd>%!jq .<cr>", { desc = "pretty json" })

-- Move Lines
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
vim.keymap.set("n", "<leader>bc", "<cmd>bprevious<bar>bd #<cr>", { desc = "Close buffer" })

-- open quickfix list with diagnostics
vim.keymap.set("n", "<leader>qf", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "Diagnostics to quickfix" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "decrease indenting" })
vim.keymap.set("v", ">", ">gv", { desc = "increase indenting" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local count = next and 1 or -1
	severity = vim.diagnostic.severity[severity]
	return function()
		vim.diagnostic.jump({ count = count, severity = severity })
	end
end
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
