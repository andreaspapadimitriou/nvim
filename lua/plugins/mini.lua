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
            --         require("mini.splitjoin").setup()

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
            --       require("mini.bracketed").setup({
            --         comment = { suffix = "z" },
            --   })

            -- comment
            --  require("mini.comment").setup({
            --     options = {
            --        custom_commentstring = nil,
            --       ignore_blank_line = true,
            --  },
            --})

            -- surround
            -- require("mini.surround").setup({
            --     custom_surroundings = {
            --         ["("] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
            --         ["["] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
            --         ["{"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
            --         ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
            --     },
            -- })

            -- cursorword, align, move, pairs
            -- require("mini.cursorword").setup()
            -- require("mini.align").setup()
            -- require("mini.move").setup()
            -- require("mini.pairs").setup()

            ------------------------------------------------------------------
            -- Custom Session Management
            ------------------------------------------------------------------
            local session_dir = vim.fn.expand("~/.cache/nvim-sessions")
            local max_recent = 8

            -- Ensure session directory exists
            if vim.fn.isdirectory(session_dir) ~= 1 then
                vim.fn.mkdir(session_dir, "p")
            end

            -- Disable mini.sessions autowrite (we handle it ourselves)
            require("mini.sessions").setup({
                autoread = false,
                autowrite = false,
                directory = session_dir,
                file = "", -- disable local session detection
            })

            -- Helper: Check if session name is an unnamed recent session
            local function is_recent_session(name)
                return name and name:match("^_") ~= nil
            end

            -- Helper: Get current session name (nil if none)
            local function get_current_session_name()
                local this_session = vim.v.this_session
                if this_session == "" then
                    return nil
                end
                return vim.fn.fnamemodify(this_session, ":t")
            end

            -- Helper: Generate a new recent session filename
            local function generate_recent_name()
                local parent = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                parent = parent:gsub("[^%w_-]", "_")
                local timestamp = os.date("%y%m%d_%H%M%S")
                return string.format("_%s_%s.vim", timestamp, parent)
            end

            -- Helper: Get all session files sorted by modification time (newest first)
            local function get_all_sessions()
                local sessions = {}
                for name in vim.fs.dir(session_dir) do
                    if name:match("%.vim$") then
                        local path = session_dir .. "/" .. name
                        table.insert(sessions, {
                            name = name,
                            path = path,
                            mtime = vim.fn.getftime(path),
                        })
                    end
                end
                table.sort(sessions, function(a, b)
                    return a.mtime > b.mtime
                end)
                return sessions
            end

            -- Helper: Get only recent sessions
            local function get_recent_sessions()
                local all = get_all_sessions()
                local recent = {}
                for _, s in ipairs(all) do
                    if is_recent_session(s.name) then
                        table.insert(recent, s)
                    end
                end
                return recent
            end

            -- Helper: Cleanup old recent sessions (keep only max_recent)
            local function cleanup_recent_sessions()
                local recent = get_recent_sessions()
                while #recent > max_recent do
                    local oldest = recent[#recent]
                    vim.fn.delete(oldest.path)
                    table.remove(recent)
                end
            end

            -- Helper: Check if session file exists
            local function session_exists(name)
                local path = session_dir .. "/" .. name
                return vim.fn.filereadable(path) == 1
            end

            -- Helper: Save session to a specific name
            local function save_session(name)
                local path = session_dir .. "/" .. name
                vim.cmd("mksession! " .. vim.fn.fnameescape(path))
                vim.v.this_session = path
                vim.notify("Session saved: " .. name, vim.log.levels.INFO)
                -- Refresh mini.sessions detected list
                MiniSessions.detected = {}
                for _, s in ipairs(get_all_sessions()) do
                    MiniSessions.detected[s.name] =
                        { name = s.name, path = s.path, type = "global" }
                end
            end

            -- Helper: Save to recent (creates new or overwrites current recent)
            local function save_to_recent()
                local current = get_current_session_name()
                local name
                if current and is_recent_session(current) then
                    name = current
                else
                    name = generate_recent_name()
                end
                save_session(name)
                cleanup_recent_sessions()
            end

            -- Prompt for session name with validation loop
            local function prompt_session_name(callback)
                local function do_prompt()
                    vim.ui.input({ prompt = "Session name (without .vim): " }, function(input)
                        if input == nil then
                            -- User cancelled (Esc/Ctrl+C)
                            callback(nil)
                            return
                        end
                        input = vim.trim(input)
                        if input == "" then
                            vim.notify("Session name cannot be empty", vim.log.levels.WARN)
                            do_prompt()
                            return
                        end
                        -- Add .vim extension if not present
                        local name = input:match("%.vim$") and input or (input .. ".vim")
                        -- Check if exists
                        if session_exists(name) then
                            vim.ui.select({ "Yes", "No" }, {
                                prompt = "Session '" .. name .. "' exists. Overwrite?",
                            }, function(choice)
                                if choice == "Yes" then
                                    callback(name)
                                else
                                    do_prompt()
                                end
                            end)
                        else
                            callback(name)
                        end
                    end)
                end
                do_prompt()
            end

            -- Load session
            local function load_session(name)
                local path = session_dir .. "/" .. name
                if vim.fn.filereadable(path) == 1 then
                    vim.cmd("%bwipeout!")
                    vim.cmd("source " .. vim.fn.fnameescape(path))
                    vim.v.this_session = path
                    vim.notify("Session loaded: " .. name, vim.log.levels.INFO)
                else
                    vim.notify("Session not found: " .. name, vim.log.levels.ERROR)
                end
            end

            -- Delete session
            local function delete_session(name)
                local path = session_dir .. "/" .. name
                local current = get_current_session_name()
                vim.fn.delete(path)
                vim.notify("Session deleted: " .. name, vim.log.levels.INFO)
                -- If we deleted current session, clear it
                if current == name then
                    vim.v.this_session = ""
                end
                -- Refresh detected
                MiniSessions.detected[name] = nil
            end

            -- <leader>ws - Quick Save
            vim.keymap.set("n", "<leader>ws", function()
                local current = get_current_session_name()
                if current and not is_recent_session(current) then
                    -- Named session: save to it
                    save_session(current)
                else
                    -- No session or recent session: save to recent
                    save_to_recent()
                end
            end, { desc = "Save session" })

            -- <leader>was - Save As (prompt for name)
            vim.keymap.set("n", "<leader>was", function()
                prompt_session_name(function(name)
                    if name then
                        save_session(name)
                    end
                end)
            end, { desc = "Save session as..." })

            -- <leader>wl - Load session
            vim.keymap.set("n", "<leader>wl", function()
                local sessions = get_all_sessions()
                if #sessions == 0 then
                    vim.notify("No sessions found", vim.log.levels.WARN)
                    return
                end
                local names = {}
                for _, s in ipairs(sessions) do
                    table.insert(names, s.name)
                end
                vim.ui.select(names, { prompt = "Load session:" }, function(choice)
                    if choice then
                        load_session(choice)
                    end
                end)
            end, { desc = "Load session" })

            -- <leader>wd - Delete session
            vim.keymap.set("n", "<leader>wd", function()
                local sessions = get_all_sessions()
                if #sessions == 0 then
                    vim.notify("No sessions found", vim.log.levels.WARN)
                    return
                end
                local names = {}
                for _, s in ipairs(sessions) do
                    table.insert(names, s.name)
                end
                if #sessions > 1 then
                    table.insert(names, "[Delete all sessions]")
                end
                vim.ui.select(names, { prompt = "Delete session:" }, function(choice)
                    if not choice then
                        return
                    end
                    if choice == "[Delete all sessions]" then
                        vim.ui.select({ "Yes", "No" }, {
                            prompt = "Delete ALL sessions?",
                        }, function(confirm)
                            if confirm == "Yes" then
                                for _, s in ipairs(sessions) do
                                    delete_session(s.name)
                                end
                            end
                        end)
                        return
                    end
                    vim.ui.select({ "Yes", "No" }, {
                        prompt = "Delete '" .. choice .. "'?",
                    }, function(confirm)
                        if confirm == "Yes" then
                            delete_session(choice)
                        end
                    end)
                end)
            end, { desc = "Delete session" })

            -- Exit handler
            vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                    -- Close sidekick CLI before saving session
                    pcall(function()
                        require("sidekick.cli").close()
                    end)

                    -- Delete all terminal buffers to avoid session corruption
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_is_valid(buf) then
                            local buftype = vim.bo[buf].buftype
                            if buftype == "terminal" then
                                pcall(vim.api.nvim_buf_delete, buf, { force = true })
                            end
                        end
                    end

                    local current = get_current_session_name()
                    if current and not is_recent_session(current) then
                        -- Named session: auto-save silently
                        local path = session_dir .. "/" .. current
                        vim.cmd("mksession! " .. vim.fn.fnameescape(path))
                        return
                    end

                    -- No session or recent session: save to recent
                    save_to_recent()
                end,
            })

            -- visits mappings
            vim.keymap.set("n", "<leader>ma", function()
                MiniVisits.add_label()
            end, { desc = "Add visit mark" })
            vim.keymap.set("n", "<leader>md", function()
                MiniVisits.remove_label()
            end, { desc = "Remove visit mark" })
            vim.keymap.set("n", "<leader>ml", function()
                MiniVisits.select_label()
            end, { desc = "List visit marks" })
            vim.keymap.set("n", "<leader>mp", function()
                MiniVisits.select_path()
            end, { desc = "List visit paths" })

            ------------------------------------------------------------------
            -- Statusline
            ------------------------------------------------------------------
            --     local statusline = require("mini.statusline")
            --     statusline.setup({
            --         content = {
            --             active = function()
            --                 local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            --                 local git = statusline.section_git({ trunc_width = 40 })
            --                 local diagnostics = statusline.section_diagnostics({
            --                     trunc_width = 75,
            --                     signs = { ERROR = "", WARN = "", INFO = "", HINT = "" },
            --                 })
            --                 local lsp = statusline.section_lsp({ trunc_width = 75 })
            --                 local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            --                 local location = statusline.section_location({ trunc_width = 75 })
            --                 local search = statusline.section_searchcount({ trunc_width = 75 })
            --                 local diff = statusline.section_diff({ trunc_width = 75 })

            --                 return statusline.combine_groups({
            --                     { hl = mode_hl, strings = { mode } },
            --                     { hl = "MiniStatuslineDevinfo", strings = { diff, diagnostics, lsp } },
            --                     "%<",
            --                     { hl = "MiniStatuslineFilename", strings = { git } },
            --                     "%=",
            --                     { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            --                     { hl = mode_hl, strings = { search, location } },
            --                 })
            --             end,
            --             inactive = function()
            --                 local filename = statusline.section_filename({ trunc_width = 140 })
            --                 local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })

            --                 return statusline.combine_groups({
            --                     "%<",
            --                     { hl = "MiniStatuslineFilename", strings = { filename } },
            --                     "%=",
            --                     { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            --                 })
            --             end,
            --         },
            --         use_icons = true,
            --     })
        end,
    },
}
