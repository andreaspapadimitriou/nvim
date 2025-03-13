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
        "commonlisp"
			},
			auto_install = true, -- Automatically install missing language parsers
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end,
    keys = {
      {
        "<leader>tc",
        function()
          require("treesitter-context").toggle()
        end,
        mode = "n",
        desc = "TScontext",
      },
    }
   },
   {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
          strategy = {
              [''] = rainbow_delimiters.strategy['global'],
              commonlisp = rainbow_delimiters.strategy['local'],
          },
          query = {
              [''] = 'rainbow-delimiters',
              lua = 'rainbow-blocks',
          },
          priority = {
              [''] = 110,
              lua = 210,
          },
          highlight = {
              'RainbowDelimiterRed',
              'RainbowDelimiterYellow',
              'RainbowDelimiterBlue',
              'RainbowDelimiterOrange',
              'RainbowDelimiterGreen',
              'RainbowDelimiterViolet',
              'RainbowDelimiterCyan',
          },
        --  blacklist = {'c', 'cpp'}, -- I don't think I will ever need this.
      }
    end
    },
}
