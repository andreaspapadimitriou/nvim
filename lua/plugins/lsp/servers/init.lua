return {
    typos_lsp = {
        init_options = { -- Sent to the LSP on init
            diagnosticSeverity = "Hint",
        },
        filetypes = {
            "*",
        },
    },
    -- azure_pipelines_ls = require("plugins.lsp.servers.azure_pipelines_ls"),
    basedpyright = require("plugins.lsp.servers.basedPyright"),
    clangd = require("plugins.lsp.servers.clangd"),
    -- cssls = require("plugins.lsp.servers.cssls"),
    lua_ls = require("plugins.lsp.servers.lua_ls"),
    tsserver = require("plugins.lsp.servers.tsserver"),
}
