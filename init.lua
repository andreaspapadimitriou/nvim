require("vim-options")
require("vim-remaps")
require("lazy-bootstrap")
require("lazy-plugins")

-- Measure Neovim startup time
local start_time = vim.loop.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local elapsed_time = (vim.loop.hrtime() - start_time) / 1e6 -- Convert nanoseconds to milliseconds
        print(string.format("Neovim started in %.2f ms", elapsed_time))
    end,
})
