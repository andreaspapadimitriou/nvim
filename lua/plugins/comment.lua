return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup {
        context_commentstring = {
          enable = true
        }
      }
    end
  },
  {
    "terrortylor/nvim-comment",
    event = 'BufRead',
    config = function()
      require('nvim_comment').setup({
        comment_empty = false,
        marker_padding = true,
        line_mapping = "gcc",
        operator_mapping = "gc",
        comment_chunk_text_object = "ic",
        hook = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })
    end
  },
}