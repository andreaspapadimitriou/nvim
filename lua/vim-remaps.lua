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

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- maintain the copied register when pasting on highlighted word in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- replace the word under the cursor in normal mode
vim.keymap.set("n", "<leader>p", '"_diwP')

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- don't store deleted text in the register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- navigate quickfix list and location list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>sr", [[:s/\%V<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Indent selected lines to the right in Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Indent selected lines to the left in Visual mode
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

--vim.keymap.set("n", "<leader><leader>", function()
--	vim.cmd("so")
--end)

vim.keymap.set("n", "<leader><leader>", function()
    vim.api.nvim_command("source ~/.config/nvim/init.lua")
    vim.api.nvim_command("source ~/.config/nvim/lua/vim-remaps.lua")
    vim.api.nvim_command("source ~/.config/nvim/lua/vim-options.lua")
end)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-l>", "<C-w>l")

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<M-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<M-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Remap Ctrl+V to paste in normal mode
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })

-- Remap Ctrl+Shift+V to paste in insert mode
vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true, silent = true })

-- Use Ctrl+Q for visual block mode
vim.api.nvim_set_keymap("n", "<C-q>", "<C-v>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-q>", "<C-v>", { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Function to notify when macro recording starts
local function notify_macro_start()
    local reg = vim.fn.reg_recording()
    vim.notify("Recording macro in register " .. reg, vim.log.levels.INFO)
end

-- Function to notify when macro recording stops
local function notify_macro_stop()
    vim.notify("Stopped recording macro", vim.log.levels.INFO)
end

-- Autocommand to notify when macro recording starts
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = notify_macro_start,
})

-- Autocommand to notify when macro recording stops
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = notify_macro_stop,
})
