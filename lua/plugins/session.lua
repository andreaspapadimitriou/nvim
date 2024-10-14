return {
    {
        "okuuva/auto-save.nvim",
        event = "BufEnter",
        keys = {
            {
                "<leader>Wab",
                "<cmd>ASToggle<CR>",
                desc = "Toggle buffer autosave",
                mode = "n",
            },
        },
        opts = {
            enabled = true,
            -- execution_message = {
            --     message = function()
            --         return "Saved at " .. os.date("%H:%M:%S")
            --     end,
            --     -- message = nil, -- this if you dont want msg
            --     dim = 0.18,                        -- dim the color of `message`
            --     cleaning_interval = 1250,          -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
            -- },
            trigger_events = {                     -- See :h events
                immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
                defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
            },
            -- Disable autosave for gitcommit buffers
            condition = function()
                local ft = vim.bo.filetype
                -- Disable autosave if the buffer is a git commit message
                if ft == "gitcommit" then
                    return false
                end
                return true
            end,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            debounce_delay = 10000, -- saves the file at most every `debounce_delay` milliseconds
            debug = false,
        },
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            { "<leader>Wr",  "<cmd>SessionSearch<CR>",         desc = "Session search" },
            { "<leader>Ws",  "<cmd>SessionSave<CR>",           desc = "Save session" },
            { "<leader>Was", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle session autosave" },
        },

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            -- ⚠️ This will only work if Telescope.nvim is installed
            -- The following are already the default values, no need to provide them if these are already the settings you want.
            session_lens = {
                -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
                load_on_setup = true,
                previewer = false,
                mappings = {
                    -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                    delete_session = { "i", "<C-D>" },
                    alternate_session = { "i", "<C-S>" },
                },
                -- Can also set some Telescope picker options
                theme_conf = {
                    border = true,
                    -- layout_config = {
                    --   width = 0.8, -- Can set width and height as percent of window
                    --   height = 0.5,
                    -- },
                },
            },
        },
    },
}
