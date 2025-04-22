-- This plugin is a wrapper around the grug-far tool,
-- which is a command-line tool for searching and replacing
-- text in files.
-- The configuration requires some refinement.
return {
    {
        "MagicDuck/grug-far.nvim",
        keys = {
            {
                "<leader>rr",
                function()
                    require("grug-far").grug_far({})
                end,
                desc = "Search and replace",
                mode = { "n", "v" },
            },
            {
                "<leader>ra",
                function()
                    require("grug-far").grug_far({ engine = "astgrep" })
                end,
                desc = "Astgrep",
                mode = { "n", "v" },
            },
        },
        config = true,
    },
}
