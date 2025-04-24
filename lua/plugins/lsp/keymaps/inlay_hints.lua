return function()
    vim.keymap.set("n", "<leader>th", function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
            { bufnr = bufnr }
        )
    end, { desc = "Toggle Inlay Hints current buffer" })

    vim.keymap.set("n", "<leader>tH", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}), {})
    end, { desc = "Toggle Inlay Hints" })

    -- Something is wrong with which-key keymap not sure why but the following doesnt work.
    -- local wk = require("which-key")
    -- wk.add({
    --     {
    --         "<leader>th",
    --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()),
    --         buffer = bufnr,
    --         desc = "Toggle inlay hints",
    --     },
    -- })
end
