return {
    {
        "ibhagwan/fzf-lua",
        -- cond = OPTIONS.fzf.value,
        cmd = {
            "FzfLua",
        },
        keys = {
            -- LEADER s
            {
                "<leader>s",

                "<cmd>FzfLua grep_visual<cr>",
                desc = "Grep string (root)",
                mode = { "v" },
            },
            {
                "<leader>s",

                "<cmd>FzfLua grep_cword<cr>",
                desc = "Grep string (root)",
                mode = { "n" },
            },
            {
                "<leader>fr",
                "<cmd>FzfLua resume<cr>",
                desc = "Resume",
                mode = { "v", "n" },
            },
            {
                "<leader>ft",
                "<cmd>FzfLua builtin<cr>",
                desc = "Builtin",
                mode = { "v", "n" },
            },
            {
                "<leader>ff",
                "<cmd>FzfLua files<cr>",
                desc = "Files (root)",
                mode = { "v", "n" },
            },
            {
                "<leader>fgf",
                "<cmd>FzfLua git_files<cr>",
                desc = "Files (git, root)",
                mode = { "v", "n" },
            },
            {
                "<leader>fs",
                "<cmd>FzfLua live_grep<cr>",
                desc = "Search (root dir)",
                mode = { "v", "n" },
            },
            {
                "<leader>fS",
                "<cmd>FzfLua live_grep_native<cr>",
                desc = "Search (faster)",
                mode = { "v", "n" },
            },
            {
                "<leader>fb",
                "<cmd>FzfLua buffers<cr>",
                desc = "buffers",
                mode = { "v", "n" },
            },
            {
                "<leader>fB",
                "<cmd>FzfLua lines<cr>",
                desc = "Grep in buffers",
                mode = { "v", "n" },
            },
            {
                "<leader>fo",
                "<cmd>FzfLua oldfiles<cr>",
                desc = "Old files (root)",
                mode = { "v", "n" },
            },
            {
                "<leader>fq",
                "<cmd>FzfLua spell_suggest<cr>",
                desc = "Dictionary",
                mode = { "v", "n" },
            },
            {
                "<leader>fk",
                "<cmd>FzfLua keymaps<cr>",
                desc = "Key Maps",
                mode = { "v", "n" },
            },

            -- GIT
            {
                "<leader>fgs",
                "<cmd>FzfLua git_status<cr>",
                desc = "Status",
                mode = { "v", "n" },
            },
            {
                "<leader>fgb",
                "<cmd>FzfLua git_branches<cr>",
                desc = "Branches",
                mode = { "v", "n" },
            },
            {
                "<leader>fgc",
                "<cmd>FzfLua git_bcommits<cr>",
                desc = "File Commits",
                mode = { "v", "n" },
            },
            {
                "<leader>fgC",
                "<cmd>FzfLua git_commits<cr>",
                desc = "Commits",
                mode = { "v", "n" },
            },

            -- DAP
            {
                "<leader>fdc",
                "<cmd>FzfLua dap_commands<cr>",
                desc = "Commands",
                mode = { "v", "n" },
            },
            {
                "<leader>fdb",
                "<cmd>FzfLua dap_breakpoints<cr>",
                desc = "Breakpoints",
                mode = { "v", "n" },
            },
            {
                "<leader>fdv",
                "<cmd>FzfLua dap_variables<cr>",
                desc = "Variables",
                mode = { "v", "n" },
            },
            {
                "<leader>fdx",
                "<cmd>FzfLua dap_configurations<cr>",
                desc = "Configurations",
                mode = { "v", "n" },
            },

            -- LSP
            {
                "<leader>flr",
                "<cmd>FzfLua lsp_references<cr>",
                desc = "References",
                mode = { "v", "n" },
            },
            {
                "<leader>fli",
                "<cmd>FzfLua lsp_incoming_calls<cr>",
                desc = "Incoming",
                mode = { "v", "n" },
            },
            {
                "<leader>flo",
                "<cmd>FzfLua lsp_outgoing_calls<cr>",
                desc = "Outgoing",
                mode = { "v", "n" },
            },
            {
                "<leader>fld",
                "<cmd>FzfLua lsp_definitions<cr>",
                desc = "Definitions",
                mode = { "v", "n" },
            },
            {
                "<leader>flt",
                "<cmd>FzfLua lsp_typedefs<cr>",
                desc = "Type Definitions",
                mode = { "v", "n" },
            },
            {
                "<leader>flj",
                "<cmd>FzfLua lsp_implementations<cr>",
                desc = "Implementations",
                mode = { "v", "n" },
            },
            {
                "<leader>fls",
                function()
                    require("fzf-lua").lsp_document_symbols({
                        symbol_style = 3,
                        winopts = {
                            preview = { hidden = "nohidden" },
                        },
                    })
                end,
                desc = "Goto Symbol",
                mode = { "v", "n" },
            },
            {
                "<leader>flS",
                function()
                    require("fzf-lua").lsp_workspace_symbols({
                        symbol_style = 3,
                        winopts = {
                            preview = { hidden = "nohidden" },
                        },
                    })
                end,
                desc = "Goto Workspace Symbol",
                mode = { "v", "n" },
            },
            {
                "<leader>fH",
                "<cmd>FzfLua helptags<cr>",
                desc = "[f]ind [h]elp",
                mode = { "v", "n" },
            },
            {
                "<leader>:",
                "<cmd>FzfLua command_history<cr>",
                desc = "Command History",
                mode = { "v", "n" },
            },
            -- Marks
            {
                "<leader>fh",
                "<cmd>FzfLua marks<cr>",
                desc = "Marks",
                mode = { "v", "n" },
            },
        },
        opts = {
            fzf_opts = {
                ["--cycle"] = "",
                ["--highlight-line"] = "",
                ["--multi"] = "",
                ["--info"] = "inline-right",
                ["--layout"] = "default",
                ["--marker"] = "▏",
                ["--pointer"] = " ▌",
                ["--prompt"] = "▌ ",
            },
            {
                "fzf-native",
                "telescope",
            },
            fzf_colors = {
                ["selected-bg"] = { "bg", "ColorColumn" },
                ["selected-fg"] = { "fg", "Normal" },
                ["bg"] = { "bg", "Normal" },
                ["bg+"] = { "fg", "SignColumnSB" },
                ["fg"] = { "fg", "Normal" },
                ["fg+"] = { "fg", "Normal" },
                ["hl"] = { "fg", "Special" },
                ["hl+"] = { "fg", "Special" },
                ["selected-hl"] = { "fg", "Special" },
                ["header"] = { "fg", "Special" },
                ["info"] = { "fg", "Special" },
                ["marker"] = { "fg", "WarningMsg" },
                ["prompt"] = { "fg", "CursorLineNr" },
                ["pointer"] = { "fg", "Special" },
                ["spinner"] = { "fg", "Special" },
                ["query"] = { "fg", "Special" },
                ["disabled"] = { "fg", "Normal" },
                ["border"] = { "fg", "Normal" },
                ["separator"] = { "fg", "Normal" },
                ["label"] = { "fg", "Normal" },
            },
            defaults = {
                formatter = "path.filename_first",
            },
            winopts = {
                on_create = function()
                    vim.keymap.set(
                        "t",
                        "<C-r>",
                        [['<C-\><C-N>"'.nr2char(getchar()).'pi']],
                        { expr = true, buffer = true }
                    )
                end,
            },
            files = {
                prompt = "Files> ",
            },
            grep = {
                rg_glob = true,
                -- first returned string is the new search query
                -- second returned string are (optional) additional rg flags
                -- @return string, string?
                rg_glob_fn = function(query, _)
                    local regex, flags = query:match("^(.-)%s%-%-(.*)$")
                    -- If no separator is detected will return the original query
                    return (regex or query), flags
                end,
            },
        },
        config = true,
    },
}
