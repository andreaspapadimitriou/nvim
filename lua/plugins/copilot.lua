return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                server_ops_overrides = {},
                filetypes = {
                    ["grug-far"] = false,
                    ["grug-far-history"] = false,
                    ["grug-far-help"] = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    yaml = false,
                    markdown = false,
                    help = false,
                    ["."] = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true, -- false to remove autosuggest
                    hide_during_completion = true, -- this is not working well with blink
                    debounce = 150,
                },
                copilot_node_command = "node",
                server_opts_overrides = {},
            })

            local ok, suggestion = pcall(require, "copilot.suggestion")
            if not ok then
                return
            end

            local map = function(lhs, rhs, desc)
                vim.keymap.set("i", lhs, rhs, { silent = true, desc = desc })
            end

            map("<M-a>", suggestion.accept, "[copilot] accept")
            map("<M-w>", suggestion.accept_word, "[copilot] accept word")
            map("<M-l>", suggestion.accept_line, "[copilot] accept line")
            map("<M-]>", suggestion.next, "[copilot] next")
            map("<M-[>", suggestion.prev, "[copilot] prev")
            map("<C-]>", suggestion.dismiss, "[copilot] dismiss")
        end,
    }
}
