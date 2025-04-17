return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        keys = {
            {
                "<leader>WS",
                function()
                    require("persistence").load()
                end,
                mode = "n",
                desc = "Load session",
            },
            {
                "<leader>WP",
                function()
                    local persistence = require("persistence")
                    local sessions_dir = vim.fn.stdpath("state") .. "/sessions/"
                    local sessions = vim.fn.globpath(sessions_dir, "*.vim", false, true)

                    if not sessions or #sessions == 0 then
                        vim.notify("No sessions found", vim.log.levels.INFO)
                        return
                    end

                    local pickers = require("telescope.pickers")
                    local finders = require("telescope.finders")
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    pickers.new({}, {
                        prompt_title = "Select Session",
                        finder = finders.new_table({
                            results = sessions,
                            entry_maker = function(session)
                                return {
                                    value = session,
                                    display = vim.fn.fnamemodify(session, ":t:r"),
                                    ordinal = session,
                                }
                            end,
                        }),
                        sorter = require("telescope.config").values.generic_sorter({}),
                        attach_mappings = function(prompt_bufnr, map)
                            local select_session = function()
                                local selection = action_state.get_selected_entry()
                                actions.close(prompt_bufnr)
                                persistence.load({ session = selection.value })
                            end

                            map("i", "<CR>", select_session)
                            map("n", "<CR>", select_session)
                            return true
                        end,
                    }):find()
                end,
                mode = "n",
                desc = "Pick session (Telescope)",
            },
            {
                "<leader>WL",
                function()
                    require("persistence").load({ last = true })
                end,
                mode = "n",
                desc = "Last session",
            },
            {
                "<leader>WD",
                function()
                    require("persistence").stop()
                end,
                mode = "n",
                desc = "Stop session",
            },
        },
        opts = {
            branch = true,
        },
    },
}