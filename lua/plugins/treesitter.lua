--- `treesitter_config.lua`: Configuration for enhanced syntax highlighting and code manipulation in Neovim using `nvim-treesitter`.
-- This file sets up the following features:
-- 1. **Treesitter Syntax Highlighting**: Enables advanced syntax highlighting using Treesitter for a variety of languages, ensuring more accurate and context-aware highlighting than traditional methods.
-- 2. **Rainbow Brackets**: Adds rainbow-colored brackets for better visibility and readability, especially in nested code structures.
-- 3. **Indentation Management**: Configures automatic indentation based on the syntax tree, with specific settings for certain file types (e.g., disabling for YAML).
-- 4. **Automatic Parser Installation**: Ensures necessary language parsers are installed and up-to-date, enabling Treesitter functionality across various languages.

return {
	{
		"nvim-treesitter/nvim-treesitter",
		cond = not vim.g.vscode,
		build = ":TSUpdate", -- Ensures all installed parsers are up-to-date
		event = { "BufReadPost", "BufNewFile" }, -- Load Treesitter when a buffer is read or created
		opts = {
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = true, -- Uses traditional regex highlighting in addition to Treesitter
			},
			rainbow = {
				enable = true,
				extended_mode = true, -- Enables rainbow brackets for all bracket-like structures
				max_file_lines = 10000, -- Limits rainbow bracket functionality to files with fewer than 10,000 lines
			},
			indent = {
				enable = true,
				disable = { "yaml" }, -- Disables automatic indentation for YAML files
			},
			ensured_install = {
				"bash",
				"c",
				"cpp",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"rust",
				"vim",
				"vimdoc",
				"json",
				"yaml",
			},
			auto_install = true, -- Automatically install missing language parsers
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
