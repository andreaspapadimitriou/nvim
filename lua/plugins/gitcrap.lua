-- return {
-- 	{
-- 		"lewis6991/gitsigns.nvim",
-- 		config = function()
-- 			require("gitsigns").setup{
--                 auto_attach = true,
--                 attach_to_untracked = false,
--                 current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
--                 current_line_blame_opts = {
--                   virt_text = true,
--                   virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
--                   delay = 100,
--                   ignore_whitespace = false,
--                   virt_text_priority = 100,
--                   use_focus = true,
--                 },
--             }
-- 			vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
-- 			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {})
--             vim.keymap.set("n", "<leader>gH", ":Gitsigns preview_hunk_inline<CR>", {})
--             vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", {})
--             vim.keymap.set("n", "<leader>gN", ":Gitsigns prev_hunk<CR>", {})
--         end,
-- 	},
--     {
--         "tpope/vim-fugitive",
--         lazy = false,
--         event = "BufEnter",
--         keys = {
--             {
--                 "<leader>gc",
--                 "<cmd>G commit<cr>",
--                 desc = "Git commit",
--             },
--             {
--                 "<leader>gl",
--                 "<cmd>G! log --max-count=50<cr>",
--                 desc = "Git log",
--             },
--             {
--                 "<leader>G",
--                 "<cmd>G<cr>",
--                 desc = "Git status",
--             },
--             {
--                 "<leader>gP",
--                 "<cmd>G! push --force-with-lease<cr>",
--                 desc = "Git push force",
--             },
--             {
--                 "<leader>gF",
--                 "<cmd>G! pull<cr>",
--                 desc = "Git pull",
--             },
--         },
--     },
--     {
--         "cedarbaum/fugitive-azure-devops.vim",
--     },
--     {
--         "tpope/vim-rhubarb",
--         config = function()
--             vim.keymap.set("n", "<leader>gB", ":GBrowse", {})
--         end,
--     },
--     {
--         "isakbm/gitgraph.nvim",
--         opts = {
--             symbols = {},
--             format = {
--                 timestamp = "%H:%M:%S %d-%m-%Y",
--                 fields = { "hash", "timestamp", "author", "branch_name", "tag" },
--             },
--             hooks = {
--                 on_select_commit = function(commit)
--                     vim.notify("DiffviewOpen " .. commit.hash .. "^!")
--                     vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
--                 end,
--                 -- Check diff from commit a -> commit b
--                 on_select_range_commit = function(from, to)
--                     vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
--                     vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
--                 end,
--             },
--         },
--         keys = {
--             {
--                 "<leader>gL",
--                 function()
--                     require("gitgraph").draw({}, { all = true, max_count = 5000 })
--                 end,
--                 desc = "Git graph",
--             },
--         },
--     },
-- }
return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            signcolumn = true,
            numhl = true,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                follow_files = true,
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align",
                delay = 500,
                virt_text_priority = 100,
                ignore_whitespace = true,
            },
            current_line_blame_formatter = "<author> <author_time:%Y %m %d> <summary>",
            max_file_length = 5000,
            trouble = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local wk = require("which-key")

                -- Navigation
                wk.add({
                    {
                        "]h",
                        function()
                            if vim.wo.diff then
                                return "]h"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("next", { wrap = true })
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Next Hunk",
                    },
                    {
                        "[h",
                        function()
                            if vim.wo.diff then
                                return "[h"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("prev", { wrap = true })
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Prev Hunk",
                    },
                    {
                        "]H",
                        function()
                            if vim.wo.diff then
                                return "]H"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("last")
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "Last Hunk",
                    },
                    {
                        "[H",
                        function()
                            if vim.wo.diff then
                                return "[H"
                            end
                            vim.schedule(function()
                                gs.nav_hunk("first")
                            end)
                            return "<Ignore>"
                        end,
                        buffer = bufnr,
                        mode = { "n", "v" },
                        expr = true,
                        replace_keycodes = false,
                        desc = "First Hunk",
                    },
                    {
                        "<leader>gq",
                        gs.setqflist,
                        mode = "n",
                        buffer = bufnr,
                        desc = "List buffer hunks",
                    },
                    {
                        "<leader>gQ",
                        function()
                            gs.setqflist("all")
                        end,
                        mode = "n",
                        buffer = bufnr,
                        desc = "List all hunks",
                    },
                    {
                        "gs",
                        gs.stage_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "<leader>gR",
                        gs.reset_buffer,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Reset Buffer",
                    },
                    {
                        "<leader>gr",
                        gs.reset_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "gS",
                        gs.stage_buffer,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Stage Buffer",
                    },
                    {
                        "<leader>gu",
                        gs.undo_stage_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Undo stage Hunk",
                    },
                    {
                        "<leader>gp",
                        gs.preview_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Preview Hunk",
                    },
                    {
                        "gs",
                        function()
                            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "<leader>gr",
                        function()
                            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "gh",
                        gs.stage_hunk("Stage Hunk"),
                        mode = "n",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "gH",
                        gs.reset_hunk,
                        mode = "n",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "gh",
                        function()
                            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Stage Hunk",
                    },
                    {
                        "gH",
                        function()
                            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                        end,
                        mode = "v",
                        buffer = bufnr,
                        desc = "Reset Hunk",
                    },
                    {
                        "ih",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        mode = { "o", "x" },
                        buffer = bufnr,
                        desc = "Hunk",
                    },
                    {
                        "ah",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        mode = { "o", "x" },
                        buffer = bufnr,
                        desc = "Hunk",
                    },
                })
            end,
        },
    },
}