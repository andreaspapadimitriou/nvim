return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "BufEnter",
		keys = {
			{
				"<leader>gc",
				"<cmd>G commit<cr>",
				desc = "Git commit",
			},
			{
				"<leader>gl",
				"<cmd>G! log --max-count=50<cr>",
				desc = "Git log",
			},
			{
				"<leader>gs",
				"<cmd>G<cr>",
				desc = "Git status",
			},
			{
				"<leader>gP",
				"<cmd>G! push --force-with-lease<cr>",
				desc = "Git push force",
			},
			{
				"<leader>gF",
				"<cmd>G! pull<cr>",
				desc = "Git pull",
			},
		},
	},
    {
        "isakbm/gitgraph.nvim",
        opts = {
            symbols = {},
            format = {
                timestamp = "%H:%M:%S %d-%m-%Y",
                fields = { "hash", "timestamp", "author", "branch_name", "tag" },
            },
            hooks = {
                on_select_commit = function(commit)
                    vim.notify("DiffviewOpen " .. commit.hash .. "^!")
                    vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                    vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                end,
            },
        },
        keys = {
            {
                "<leader>gL",
                function()
                    require("gitgraph").draw({}, { all = true, max_count = 5000 })
                end,
                desc = "Git graph",
            },
        },
    },
}
