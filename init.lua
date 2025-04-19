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
