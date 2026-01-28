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
          terminal = {
        enabled = true,
        keys = {
            q = "hide",
            gf = function(self)
                local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                if f == "" then
                    Snacks.notify.warn("No file under cursor")
                else
                    self:hide()
                    vim.schedule(function()
                        vim.cmd("e " .. f)
                    end)
                end
            end,
        },
    },
        picker = {
        enabled = true,
        previewers = {
            diff = {
                cmd = { "delta" },
            },
        },
        formatters = {
            file = {
                filename_first = true,
                truncate = 40,
            },
        },
    },
    },

    keys = require("plugins.snacks.keymaps"),
}
