-- clangd_extensions.nvim plugin spec
--
-- Provides a set of UI helpers and extra LSP features for clangd:
-- - AST viewer (`:ClangdAST`) with icons and folding
-- - Symbol info (`:ClangdSymbolInfo`) for the symbol under cursor
-- - Type hierarchy (`:ClangdTypeHierarchy`)
-- - Memory usage viewer (`:ClangdMemoryUsage`)
-- - Switch between source/header (`:ClangdSwitchSourceHeader`)
--
-- This file registers the plugin with lazy.nvim and sets sensible
-- defaults (AST icons). It loads on C-family filetypes.
-- If your terminal font doesn't support codicon glyphs, replace the
-- glyphs with Unicode fallbacks or set `vim.g.have_nerd_font` accordingly.

return {
    {
        "p00f/clangd_extensions.nvim",
        dependencies = {
            "mortepau/codicons.nvim",
        },
        ft = { "c", "cpp", "objc", "objcpp" },
        lazy = true,
        config = function(_, opts)
            require("clangd_extensions").setup(opts)
        end,
        opts = {
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },
}
