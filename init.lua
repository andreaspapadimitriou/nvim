require("vim-options")
require("vim-remaps")
require("config.lazy-bootstrap")
require("config.lazy-plugins")

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		local log_file = vim.fn.stdpath("state") .. "/lsp.log"
		local f = io.open(log_file, "w")
		if f then
			f:close()
		end
	end,
})

-- Measure Neovim startup time
local start_time = vim.loop.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local elapsed_time = (vim.loop.hrtime() - start_time) / 1e6 -- Convert nanoseconds to milliseconds
        print(string.format("Neovim started in %.2f ms", elapsed_time))
    end,
})
