-- Snacks keymaps
-- Organized by functionality

return {
    -- Lazygit
    {
        "<leader>gg",
        function()
            Snacks.lazygit()
        end,
        desc = "Lazygit",
    },

    -- Zen mode and Zoom
    {
        "<leader>uz",
        function()
            Snacks.toggle.zen():toggle()
        end,
        desc = "Zen Mode",
    },
    {
        "<leader>uZ",
        function()
            Snacks.toggle.zoom():toggle()
        end,
        desc = "Zoom",
    },
}
