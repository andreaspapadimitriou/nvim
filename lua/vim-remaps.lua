-- in visual mode move up and down stuff
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to the end of the current
vim.keymap.set("n", "J", "mzJ`z")

-- keep things centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- maintain the copied register when pasting on highlighted word in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- replace the word under the cursor in normal mode
vim.keymap.set("n", "<leader>p", '"_diwP')

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- don't store deleted text in the register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Indent selected lines to the right in Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Indent selected lines to the left in Visual mode
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- replace shortcuts
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>sr", [[:s/\%V<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

 -- TIP: Disable arrow keys in normal mode
 vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
 vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
 vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
 vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

-- Remap Ctrl+V to paste in normal mode
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })

-- Remap Ctrl+Shift+V to paste in insert mode
vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })

-- Use Ctrl+Q for visual block mode
vim.api.nvim_set_keymap("n", "<C-q>", "<C-v>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-q>", "<C-v>", { noremap = true, silent = true })

-- lsp restart
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Toggle word wrap (@TODO this can be replaced later on)
local toggle_word_wrap = function()
	if vim.wo.wrap then
		-- Disable wrap
		vim.opt.wrap = false
		print("Word wrap disabled")
	else
		-- Enable wrap and set custom j/k mappings
		vim.opt.wrap = true
		vim.keymap.set("n", "j", function()
			return vim.v.count > 0 and "j" or "gj"
		end, { expr = true, desc = "Move down respecting wrapped lines" })

		vim.keymap.set("n", "k", function()
			return vim.v.count > 0 and "k" or "gk"
		end, { expr = true, desc = "Move up respecting wrapped lines" })
		print("Word wrap enabled")
	end
end
-- Bind the toggle to a key, e.g., <leader>w
vim.keymap.set("n", "<leader>w", toggle_word_wrap, { desc = "Toggle Word Wrap" })