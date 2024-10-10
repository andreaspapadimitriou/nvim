return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
--    vim.cmd[[highlight Normal guibg=NONE ctermbg=NONE]]
--    vim.cmd[[highlight NonText guibg=NONE ctermbg=NONE]]
  end,
}
