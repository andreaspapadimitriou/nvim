return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })

            local wk = require("which-key")
            wk.add({
                {
                    "gd",
                    vim.lsp.buf.definition,
                    desc = "Go to definition",
                    mode = "n",
                },
                {
                    "K",
                    vim.lsp.buf.hover,
                    desc = "Hover",
                    mode = "n",
                },
                {
                    "<leader>ca",
                    vim.lsp.buf.code_action,
                    desc = "Code action",
                    mode = "n",
                },
                {
                    "gD",
                    vim.lsp.buf.declaration,
                    buffer = bufnr,
                    desc = "Go to declaration",
                },
                {
                    "gd",
                    vim.lsp.buf.definition,
                    buffer = bufnr,
                    desc = "Go to definition",
                },
                {
                    "gi",
                    vim.lsp.buf.implementation,
                    buffer = bufnr,
                    desc = "Go to implementation",
                },
                {
                    "gr",
                    require("fzf-lua").lsp_references(),
                    buffer = bufnr,
                    desc = "Go to references",
                },
                {
                    "<c-s>",
                    vim.lsp.buf.signature_help,
                    buffer = bufnr,
                    desc = "Signature",
                },
                {
                    "<leader>d",
                    function()
                        require("conform").format({ async = true, lsp_fallback = true })
                    end,
                    buffer = bufnr,
                    desc = "Format",
                },
                {
                    "<leader>rn",
                    vim.lsp.buf.rename,
                    buffer = bufnr,
                    desc = "Rename",
                },
                {
                    "<leader>La",
                    vim.lsp.buf.add_workspace_folder,
                    buffer = bufnr,
                    desc = "Add workspace folder",
                },
                {
                    "<leader>Lr",
                    vim.lsp.buf.remove_workspace_folder,
                    buffer = bufnr,
                    desc = "Remove workspace folder",
                },
                {
                    "<leader>Ll",
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    buffer = bufnr,
                    desc = "List workspace folder",
                },
                {
                    "<leader>Ld",
                    function()
                        vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
                    end,
                    buffer = bufnr,
                    desc = "Toggle diagnostics for current buffer",
                },
                {
                    "<leader>LD",
                    function()
                        vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = nil }), {
                            bufnr = nil,
                        })
                    end,
                    buffer = bufnr,
                    desc = "Toggle diagnostics buffers",
                },
                {
                    "<leader>ld",
                    function()
                        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
                    end,
                    desc = "Open float diagnostic",
                },
            })
        end,
    },
}
