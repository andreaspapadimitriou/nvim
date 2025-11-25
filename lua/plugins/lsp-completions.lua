-- Lightweight completion helpers
-- Installs and configures basic lsp completion helpers:
-- - `onsails/lspkind.nvim` for pictograms in completion items
-- - `hrsh7th/cmp-nvim-lsp` to provide LSP capabilities to nvim-cmp
-- The specs are lazy-loaded; lspkind is initialized with icons from `utils.icons`.

return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "onsails/lspkind.nvim", "hrsh7th/cmp-nvim-lsp" },
    },
}
