return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts = {
                    ensure_installed = {
                        -- NOTE: LSP
                        -- "basedpyright", -- missing config
                        "clangd",
                        -- "cmake-language-server", -- missing config
                        "lua-language-server",
                        -- "marksman",
                        -- "arduino-language-server",
                        "typos-lsp",

                        -- NOTE: LINT
                        -- "buf",
                        -- "buildifier",
                        -- "cmakelint",
                        -- "eslint_d",
                        -- "hadolint",
                        -- "jsonlint",
                        -- "luacheck",
                        -- "markdownlint",
                        -- "shellcheck",
                        -- "stylelint",

                        -- NOTE: FORMAT
                        -- "autoflake",
                        "clang-format",
                        -- "autopep8",
                        -- "beautysh",
                        -- "fixjson",
                        -- "prettier",
                        -- "prettierd",
                        -- "shfmt",
                        -- "stylua",
                    },
                },
            },
        },
    },
}
