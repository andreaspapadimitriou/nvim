-- by default all servers are enabled
vim.lsp.enable("clangd")

-- LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client == nil then
            return
        end

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Mappings
        require("config.keymaps").default(bufnr)
        if client.server_capabilities.inlayHintProvider then
            require("config.keymaps").inlay_hints(bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client.name == "clangd" then
            require("config.keymaps").clangd(bufnr)
        end
        -- Normal Mode
    end,
})

local diagnostics = require("utils.icons").diagnostics
for type, icon in pairs(diagnostics) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl, --[[numhl = hl]]
    })
end

local opts = {
    diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_lines = vim.fn.has("nvim-0.11") and {
            current_line = true,
        } or false,
        virtual_text = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostics.Error,
                [vim.diagnostic.severity.WARN] = diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = diagnostics.Info,
            },
        },
    },
    autoformat = true,
    format = {
        formatting_options = nil,
        timeout_ms = nil,
    },
    setup = {},
}

vim.diagnostic.config(vim.tbl_deep_extend("force", opts.diagnostics or {}, { signs = true }))
