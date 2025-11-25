return function(bufnr)
    local wk = require("which-key")
    wk.add({

        { "<c-s>", vim.lsp.buf.signature_help, buffer = bufnr, desc = "Signature" },
        { "<leader>a", vim.lsp.buf.code_action, buffer = bufnr, desc = "Apply fix" },
        {
            "<leader>qa",
            vim.lsp.buf.add_workspace_folder,
            buffer = bufnr,
            desc = "Add workspace folder",
        },
        {
            "<leader>qr",
            vim.lsp.buf.remove_workspace_folder,
            buffer = bufnr,
            desc = "Remove workspace folder",
        },
        {
            "<leader>qw",
            print(vim.inspect(vim.lsp.buf.list_workspace_folders())),
            buffer = bufnr,
            desc = "List workspace folder",
        },
        { "<leader>r", buffer = bufnr, group = "Refactor" },
        { "<leader>rn", vim.lsp.buf.rename, buffer = bufnr, desc = "Rename" },
        { "<leader>t", buffer = bufnr, group = "Toggle" },
        {
            "<leader>tD",
            vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = nil })),
            buffer = bufnr,
            desc = "Toggle diagnostics buffers",
        },
        {
            "<leader>td",
            vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 })),
            buffer = bufnr,
            desc = "Toggle diagnostics for current buffer",
        },
        { "g", buffer = bufnr, group = "Go to" },
        { "gD", vim.lsp.buf.declaration, buffer = bufnr, desc = "Go to declaration" },
        { "gd", vim.lsp.buf.definition, buffer = bufnr, desc = "Go to definition" },
        { "gi", vim.lsp.buf.implementation, buffer = bufnr, desc = "Go to implementation" },
        {
            "gr",
            require("fzf-lua").lsp_references,
            -- require("telescope.builtin").lsp_references({
            --     -- fname_width = require("utils.sizes").fname_width,
            --     include_declaration = false,
            --     include_current_line = true,
            --     jump_type = "never",
            -- }),
            buffer = bufnr,
            desc = "Go to references",
        },
    })
end
