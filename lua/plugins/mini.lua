return {
    {
        "echasnovski/mini.files",

        dependencies = {
            "echasnovski/mini.icons",
        },
        version = false,
        event = "BufEnter",
        keys = {
            {
                "<leader>ex",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>",
                desc = "Explorer current file",
                mode = "n",
            },
            {
                "<leader>EC",
                "<cmd>lua MiniFiles.open(nil, false)<cr>",
                desc = "CWD",

                mode = "n",
            },
            {
                "<leader>EB",
                "<cmd>lua MiniFiles.open(MiniFiles.get_latest_path())<cr>",
                desc = "Latest path",
                mode = "n",
            },
            {
                "<leader>EH",
                "<cmd>lua MiniFiles.open(vim.fn.expand('$HOME'))<cr>",
                desc = "Home",
                mode = "n",
            },
        },

        -- init = file_functions.init,
        opts = {
            options = {
                permament_delete = true,
                use_as_default_explorer = true,
            },

            windows = {
                preview = true,
                width_preview = 80,
                width_focus = 50,
                width_nofocus = 20,
            },
            -- content = {

            --     filter = file_functions.filter,
            --     sort = file_functions.sort,

            -- },
            -- mappings = {
            --     go_in = "l",
            --     go_in_plus = "L",
            --     go_out = "h",
            --     go_out_plus = "H",

            -- }
        },

        config = function(_, opts)
            require("mini.files").setup(opts)
        end,
    },

    ----------------------------------------------------------------------
    -- nvim-web-devicons shim (replaced by mini.icons)
    ----------------------------------------------------------------------
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },

    ----------------------------------------------------------------------
    -- mini.snippets
    ----------------------------------------------------------------------
    {
        "echasnovski/mini.snippets",
        version = false,
        config = function()
            local gen_loader = require("mini.snippets").gen_loader
            local snippets = {
                gen_loader.from_file(vim.fn.stdpath("config") .. "snippets/global.json"),
                gen_loader.from_lang(),
            }

            if vim.g.extra_snippets ~= nil then
                snippets = vim.tbl_deep_extend("force", snippets, vim.g.extra_snippets(gen_loader))
            end

            require("mini.snippets").setup({
                snippets = snippets,
                mappings = {
                    expand = "",
                    jump_next = "",
                    jump_prev = "",
                    stop = "",
                },
            })

            local make_stop = function()
                local au_opts = { pattern = "*:n", once = true }
                au_opts.callback = function()
                    while MiniSnippets.session.get() do
                        MiniSnippets.session.stop()
                    end
                end
                vim.api.nvim_create_autocmd("ModeChanged", au_opts)
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniSnippetsSessionStart",
                callback = make_stop,
            })
        end,
    },

    ----------------------------------------------------------------------
    -- mini.splitjoin, visits, icons, extra, ai, bracketed, comment, surround
    ----------------------------------------------------------------------
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            -- splitjoin
            require("mini.splitjoin").setup()

            -- visits
            require("mini.visits").setup()

            -- icons
            require("mini.icons").setup({
                file = {
                    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
                },
                filetype = {
                    dotenv = { glyph = "", hl = "MiniIconsYellow" },
                },
            })

            -- extra (needed for ai)
            require("mini.extra").setup()
            local gen_ai_spec = require("mini.extra").gen_ai_spec

            -- ai
            require("mini.ai").setup({
                custom_textobjects = {
                    B = gen_ai_spec.buffer(),
                    D = gen_ai_spec.diagnostic(),
                    I = gen_ai_spec.indent(),
                    L = gen_ai_spec.line(),
                    N = gen_ai_spec.number(),
                },
                n_lines = 500,
            })

            -- bracketed
            require("mini.bracketed").setup({
                comment = { suffix = "z" },
            })

            -- comment
            require("mini.comment").setup({
                options = {
                    custom_commentstring = nil,
                    ignore_blank_line = true,
                },
            })

            -- surround
            require("mini.surround").setup({
                custom_surroundings = {
                    ["("] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
                    ["["] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
                    ["{"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
                    ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
                },
            })

            -- cursorword, align, move, pairs
            require("mini.cursorword").setup()
            require("mini.align").setup()
            require("mini.move").setup()
            require("mini.pairs").setup()

            -- sessions
            require("mini.sessions").setup({
                autoread = true,
                autowrite = true,
                directory = vim.fn.stdpath("data") .. "/sessions",
                file = "Session.vim",
            })

            vim.keymap.set("n", "<leader>ws", function()
                MiniSessions.write("Session.vim")
            end, { desc = "Save session" })

            -- visits mappings
            vim.keymap.set("n", "<leader>ma", function() MiniVisits.add_label() end, { desc = "Add visit mark" })
            vim.keymap.set("n", "<leader>md", function() MiniVisits.remove_label() end, { desc = "Remove visit mark" })
            vim.keymap.set("n", "<leader>ml", function() MiniVisits.select_label() end, { desc = "List visit marks" })
            vim.keymap.set("n", "<leader>mp", function() MiniVisits.select_path() end, { desc = "List visit paths" })

            ------------------------------------------------------------------
            -- Statusline
            ------------------------------------------------------------------
            local statusline = require("mini.statusline")
            statusline.setup({
                content = {
                    active = function()
                        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                        local git = statusline.section_git({ trunc_width = 40 })
                        local diagnostics = statusline.section_diagnostics({
                            trunc_width = 75,
                            signs = { ERROR = "", WARN = "", INFO = "", HINT = "" },
                        })
                        local lsp = statusline.section_lsp({ trunc_width = 75 })
                        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
                        local location = statusline.section_location({ trunc_width = 75 })
                        local search = statusline.section_searchcount({ trunc_width = 75 })
                        local diff = statusline.section_diff({ trunc_width = 75 })

                        return statusline.combine_groups({
                            { hl = mode_hl, strings = { mode } },
                            { hl = "MiniStatuslineDevinfo", strings = { diff, diagnostics, lsp } },
                            "%<",
                            { hl = "MiniStatuslineFilename", strings = { git } },
                            "%=",
                            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                            { hl = mode_hl, strings = { search, location } },
                        })
                    end,
                    inactive = function()
                        local filename = statusline.section_filename({ trunc_width = 140 })
                        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })

                        return statusline.combine_groups({
                            "%<",
                            { hl = "MiniStatuslineFilename", strings = { filename } },
                            "%=",
                            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                        })
                    end,
                },
                use_icons = true,
            })
        end,
    },

}
