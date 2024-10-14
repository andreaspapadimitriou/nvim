return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'BufRead',
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require('ts_context_commentstring').setup {}
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