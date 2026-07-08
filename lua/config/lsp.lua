vim.lsp.enable({ -- all require manual installation of servers
    "lua_ls",
    "clangd",
    "typos_lsp",
    "basedpyright",
    "jsonls",
    "marksman",
    "cmake",
    "bashls",
    "copilot",
})
-- Allow requiring modules placed directly under the config root (e.g. `lsp/*`).
-- This keeps your `lsp/` folder loadable without moving files into `lua/`.
do
    local config_path = vim.fn.stdpath("config")
    local extra_paths = config_path .. "/?.lua;" .. config_path .. "/?/init.lua"
    if not string.find(package.path, extra_paths, 1, true) then
        package.path = package.path .. ";" .. extra_paths
    end
end

-- LspAttach -- my old one
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(args)
--         local bufnr = args.buf
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--         if client == nil then
--             return
--         end
--
--         -- Enable completion triggered by <c-x><c-o>
--         vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
--         -- Mappings
--         local keymaps = require("lsp.lsp-keymaps")
--         keymaps.default(bufnr)
--         if client.server_capabilities.inlayHintProvider then
--             keymaps.inlay_hints(bufnr)
--             vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--         end
--
--         if client.name == "clangd" then
--             keymaps.clangd(bufnr)
--         end
--         -- Normal Mode
--     end,
-- })

-- The following is added here to remind that there is autocompletion built-in in nvim 0.11
-- so maybe no need to install nvim-cmp or other completion plugins.
-- Initialize autoformat as enabled by default
vim.g.autoformat = true

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Enable autoformat for this buffer by default
        -- jsonls formats generically and doesn't match the repo's schema-based
        -- format_json.py pre-commit hook, so disable autoformat-on-save for json to avoid producing diffs.
        vim.b[bufnr].autoformat = vim.bo[bufnr].filetype ~= "json"

        if client:supports_method("textDocument/complemetion") then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set("i", "<C-Space>", function()
                vim.lsp.completion.get()
            end)
        end

        local keymaps = require("lsp.lsp-keymaps")
        keymaps.default(bufnr)
        if client.server_capabilities.inlayHintProvider then
            keymaps.inlay_hints(bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        if client.name == "clangd" then
            keymaps.clangd(bufnr)
        end

        if client:supports_method("textDocument/formatting") then
            vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"

            if not client:supports_method("textDocument/willSaveWaitUntil") then
                local group = vim.api.nvim_create_augroup(
                    "BufSave_" .. bufnr .. "_" .. client.id,
                    { clear = true }
                )
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = group,
                    buffer = bufnr,
                    callback = function()
                        if vim.b[bufnr].autoformat and vim.g.autoformat then
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                id = client.id,
                                async = false,
                            })
                        end
                    end,
                })
            end
        end
    end,
})

vim.diagnostic.config({
    virtual_lines = { current_line = true },
})

-- local diagnostics = require("utils.icons").diagnostics
-- for type, icon in pairs(diagnostics) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, {
--         text = icon,
--         texthl = hl, --[[numhl = hl]]
--     })
-- end
--
-- local opts = {
--     diagnostics = {
--         underline = true,
--         update_in_insert = false,
--         severity_sort = true,
--         virtual_lines = vim.fn.has("nvim-0.11") and {
--             current_line = true,
--         } or false,
--         virtual_text = false,
--         signs = {
--             text = {
--                 [vim.diagnostic.severity.ERROR] = diagnostics.Error,
--                 [vim.diagnostic.severity.WARN] = diagnostics.Warn,
--                 [vim.diagnostic.severity.HINT] = diagnostics.Hint,
--                 [vim.diagnostic.severity.INFO] = diagnostics.Info,
--             },
--         },
--     },
--     autoformat = true,
--     format = {
--         formatting_options = nil,
--         timeout_ms = nil,
--     },
--     setup = {},
-- }
--
-- vim.diagnostic.config(vim.tbl_deep_extend("force", opts.diagnostics or {}, { signs = true }))
