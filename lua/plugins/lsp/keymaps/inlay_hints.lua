return function(bufnr)
    local wk = require("which-key")
    wk.add({
        {
            "<leader>th",
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()),
            buffer = bufnr,
            desc = "Toggle inlay hints",
        },
    })
end
