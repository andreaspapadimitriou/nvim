---@brief lsp-config for copilot-language-server
---@see https://github.com/github/copilot-language-server-release
local home = vim.env.HOME
return {
    cmd = { home .. "/.local/share/nvim011/bin/copilot-language-server", "--stdio" },
    root_markers = { ".git", ".hg" },
    filetypes = nil, -- attach to all filetypes
    init_options = {
        copilot = {
            -- Enable nextEditSuggestions for sidekick.nvim NES
            nextEditSuggestions = {
                enabled = true,
            },
        },
    },
}
