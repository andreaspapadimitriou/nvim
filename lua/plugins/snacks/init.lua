local snacks_path = vim.fn.stdpath("config") .. "/lua/plugins/snacks/snacks/?.lua"
package.path = package.path .. ";" .. snacks_path

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = false }, -- that is like alpha!
        explorer = { enabled = false },
        indent = { enabled = false },
        input = {
            enabled = false, -- even if true not working
            {
                backdrop = false,
                position = "float",
                border = "rounded",
                title_pos = "center",
                height = 1,
                width = 60,
                relative = "editor",
                noautocmd = true,
                row = 2,
                -- relative = "cursor",
                -- row = -3,
                -- col = 0,
                wo = {
                    winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                    cursorline = false,
                },
                bo = {
                    filetype = "snacks_input",
                    buftype = "prompt",
                },
                --- buffer local variables
                b = {
                    completion = false, -- disable blink completions in input
                },
                keys = {
                    n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                    i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
                    i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
                    i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
                    i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
                    i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
                    q = "cancel",
                },
            },
        }, -- that looks nice to replace mine!
        picker = { enabled = false },
        notifier = { enabled = false }, -- that looks a bit better than the default
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = require("scroll")({ enabled = true }),
        statuscolumn = { enabled = false },
        words = { enabled = true },
        lazygit = require("lazygit")({ enabled = true }),
    },

    keys = require("plugins.snacks.keymaps.lazygit"),
    -- more keymaps to be added...
}
