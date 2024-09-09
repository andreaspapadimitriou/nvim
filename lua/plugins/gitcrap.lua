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
}
