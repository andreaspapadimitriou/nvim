return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "file" }, -- group
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
				{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
				{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
				{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags", mode = "n" },
			})

			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
