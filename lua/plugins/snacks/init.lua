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
        indent = require("indent")({ enabled = true }),
        zen = require("zen")({ enabled = true }),
        input = { enabled = true }, 
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = require("scope")({ enabled = true }),
        scroll = require("scroll")({ enabled = true }),
        statuscolumn = { enabled = false },
        words = require("words")({ enabled = true }),
        lazygit = require("lazygit")({ enabled = true }),
        picker = require("picker")({ enabled = true }),
    },

    keys = require("plugins.snacks.keymaps"),
}


