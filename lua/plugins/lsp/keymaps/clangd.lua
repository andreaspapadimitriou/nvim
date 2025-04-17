return function(bufnr)
    local wk = require("which-key")
    wk.add({
        { 
            "<leader>o",
            "<cmd>ClangdSwitchSourceHeader<CR>",
            buffer = bufnr,
            desc = "Switch Header/Source" 
        },
        { 
            "<leader>O",
            "<cmd>vsplit | ClangdSwitchSourceHeader<CR>",
            buffer = bufnr,
            desc = "Switch Header/Source (vsplit)"
        },
    })
end