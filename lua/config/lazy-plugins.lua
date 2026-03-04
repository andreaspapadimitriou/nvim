-- [[ Configure and install plugins ]]
require("lazy").setup({
    require("plugins.alpha"),
    -- require("plugins.autopairs"), -- can be removed or replaced?
    require("plugins.catppuccin"),
    -- require("plugins.comment"),
    -- require("plugins.completions"),
    -- require("plugins.conform"),
    require("plugins.copilot"),
    require("plugins.sidekick"),
    -- require("plugins.diffview"),
    require("plugins.flash"),
    -- require("plugins.fzf"),
    require("plugins.gitcrap"),
    -- require("plugins.grug"),
    require("plugins.lualine"), -- (I decided I like it)
    require("plugins.mini"),
    -- require("plugins.session"),
    -- require("plugins.telescope.telescope"),
    require("plugins.toggleterm"),
    require("plugins.treesitter"),
    require("plugins.trouble"),
    require("plugins.ui"), -- only bufferline is active - and that need improving
    require("plugins.undotree"),
    -- require("plugins.unception"),
    require("plugins.which_key"),
    -- require("plugins.zen"),
    -- require("plugins.clangd_extensions"),
    require("plugins.snacks.init"),
    --require("plugins.snacks"),
    require("plugins.render_markdown"),
    -- require("plugins.mason"),
    require("plugins.blink"),
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
