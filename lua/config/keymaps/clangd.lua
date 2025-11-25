return function(bufnr)
    local wk = require("which-key")
    wk.add({
        {
            "<leader>o",
            "<cmd>LspClangdSwitchSourceHeader<CR>",
            buffer = bufnr,
            desc = "Switch Header/Source",
        },
        {
            "<leader>O",
            "<cmd>vsplit | LspClangdSwitchSourceHeader<CR>",
            buffer = bufnr,
            desc = "Switch Header/Source (vsplit)",
        },
    })
end
