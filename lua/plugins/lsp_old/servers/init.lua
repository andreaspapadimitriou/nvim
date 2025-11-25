return {
    typos_lsp = {
        init_options = { -- Sent to the LSP on init
            diagnosticSeverity = "Hint",
        },
        filetypes = {
            "*",
        },
    },
    basedpyright = require("plugins.lsp.servers.basedPyright"),
    clangd = require("plugins.lsp.servers.clangd"),
    lua_ls = require("plugins.lsp.servers.lua_ls"),
    -- arduino_language_server = require("plugins.lsp.servers.arduino"),
    -- azure_pipelines_ls = require("plugins.lsp.servers.azure_pipelines_ls"),
    -- tsserver = require("plugins.lsp.servers.tsserver"),
    -- cssls = require("plugins.lsp.servers.cssls"),
}
