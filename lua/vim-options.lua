--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

--vim.cmd("set expandtab")
--vim.cmd("set tabstop=2")
--vim.cmd("set softtabstop=2")
--vim.cmd("set shiftwidth=2")
