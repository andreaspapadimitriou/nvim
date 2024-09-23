return {
	"folke/zen-mode.nvim",
	opts = {},
	config = function()
		require("zen-mode").setup({
			window = {
				width = 180,
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
					cursorcolumn = false,
				},
			},
			plugins = {
				kitty = {
					enabled = true,
					font = "+2",
				},
			},
		})
		vim.keymap.set("n", "<leader>zk", function()
			if vim.g.zen_mode_active then
				require("zen-mode").toggle()
				vim.g.zen_mode_active = false
			else
				require("zen-mode").toggle()
				vim.g.zen_mode_active = true
			end
		end, { desc = "Zen Mode Toggle" })
	end,
}
