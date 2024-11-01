-- [[ Configure and install plugins ]]
require("lazy").setup({
--    "tpope/vim-sleuth",
    require("plugins.catppuccin"),
    require("plugins.completions"),
    require("plugins.copilot"),
    require("plugins.fzf"),
    require("plugins.lsp_lines"),
    require("plugins.gitcrap"),
    require("plugins.illuminate"),
--  require("plugins.lsp-config"),
    require("plugins.lsp.init"),
    require("plugins.lualine"),
    require("plugins.mini"),
    require("plugins.neotree"),
--  require("plugins.none-ls"),
    require("plugins.session"),
    require("plugins.telescope.telescope"),
    require("plugins.alpha"),
    require("plugins.toggleterm"),
    require("plugins.treesitter"),
    require("plugins.trouble"),
    require("plugins.ui"),
    require("plugins.undotree"),
    require("plugins.flash"),
    require("plugins.autopairs"),
    require("plugins.comment"),
    require("plugins.which_key"),
    require("plugins.zen"),
    require("plugins.unception")
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

