-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- Relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

--  Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--vim.opt.list = true
--vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Wrap long text
vim.opt.wrap = false

-- Set the number of spaces that a tab character represents
vim.opt.tabstop = 4

-- Set the number of spaces inserted when pressing Tab in insert mode
vim.opt.softtabstop = 4

-- Set the number of spaces used for each step of (auto)indent
vim.opt.shiftwidth = 4

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Enable smart indentation based on file type
vim.opt.smartindent = true

-- Disable swapfile creation
vim.opt.swapfile = false

-- Disable backup file creation
vim.opt.backup = false

-- Set undo directory to store undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Enable persistent undo (saves undo history across sessions)
vim.opt.undofile = true

-- Disable search highlight after a search is completed
vim.opt.hlsearch = false

-- Enable incremental search (shows matches as you type)
vim.opt.incsearch = true

-- Enable true color support for better color schemes
vim.opt.termguicolors = true

-- Always show the sign column (prevents shifting of text)
vim.opt.signcolumn = "yes"

-- Append "@-@" to the list of valid filename characters
vim.opt.isfname:append("@-@")

-- Reduce the time (in ms) for triggering events like CursorHold
vim.opt.updatetime = 200

-- Disable highlighting of a specific column (e.g., for line length)
vim.opt.colorcolumn = ""
