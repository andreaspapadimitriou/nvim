return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        image = {
            enabled = true,
            force = false,
        },

        gh = {},

        lazygit = {
            configure = true,
        },

        explorer = {
            enabled = false,
        },

        picker = {
            enabled = true,
            previewers = {
                diff = { cmd = { "delta" } },
            },
            formatters = {
                file = {
                    filename_first = true,
                    truncate = 40,
                },
            },
        },

        bigfile = { enabled = true },

        scroll = {
            animate = {
                duration = { step = 10, total = 50 },
                easing = "linear",
            },
        },

        input = { enabled = true },

        zen = {
            toggles = {
                dim = false,
                git_signs = true,
                diagnostics = true,
                inlay_hints = true,
            },
            show = {
                statusline = false,
                tabline = false,
            },
            zoom = {
                toggles = {},
                show = { statusline = true, tabline = true },
                win = {
                    backdrop = false,
                    width = 0,
                },
            },
        },

        terminal = {
            keys = {
                q = "hide",
                gf = function(self)
                    local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                    if f == "" then
                        Snacks.notify.warn("No file under cursor")
                    else
                        self:hide()
                        vim.schedule(function()
                            vim.cmd("e " .. f)
                        end)
                    end
                end,
            },
        },

        scope = { enabled = true },

        indent = {
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
                easing = "linear",
                duration = { step = 20, total = 100 },
            },
            scope = {
                enabled = true,
                underline = false,
            },
            chunk = {
                enabled = true,
                only_current = true,
                hl = "SnacksIndentChunk",
                char = {
                    corner_top = "┌",
                    corner_bottom = "└",
                    horizontal = "─",
                    vertical = "│",
                    arrow = ">",
                },
            },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
            end,
        },

        dashboard = { enabled = false },

        notifier = {
            enabled = true,
            timeout = 3000,
            max_notifications = 4,
        },

        quickfile = { enabled = true },
        bufdelete = { enabled = true },

        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" },
            right = { "fold", "git" },
            folds = { open = true, git_hl = true },
            git = { patterns = { "GitSign", "MiniDiffSign" } },
            refresh = 50,
        },

        words = { enabled = true },
    },
    config = function(_, opts)
        require("snacks").setup(opts)

        -- Your mappings (unchanged)
        ------------------------------------------------------------------
        local key = vim.keymap.set
        key("n", "<leader>gi", function() Snacks.picker.gh_issue() end)
        key("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end)
        key("n", "<leader>gq", function() Snacks.picker.gh_pr() end)
        key("n", "<leader>gQ", function() Snacks.picker.gh_pr({ state = "all" }) end)
        key("n", "<leader>/", function() Snacks.picker.grep() end)
        key("n", "<leader>:", function() Snacks.picker.command_history() end)
        key("n", "<leader>,", function() Snacks.picker.buffers() end)
        key("n", "<leader>n", function() Snacks.picker.notifications() end)
        key("n", "<leader><space>", function() Snacks.picker.smart() end)
        key("n", "<leader>fn", function() Snacks.picker.notifications() end)

        -- ... (All your remaining mappings stay exactly the same)
        ------------------------------------------------------------------

        -- LSP progress handler
        local progress = vim.defaulttable()
        vim.api.nvim_create_autocmd("LspProgress", {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value = ev.data.params.value
                if not client or type(value) ~= "table" then
                    return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                    if i == #p + 1 or p[i].token == ev.data.params.token then
                        p[i] = {
                            token = ev.data.params.token,
                            msg = ("[%3d%%] %s%s"):format(
                                value.kind == "end" and 100 or value.percentage or 100,
                                value.title or "",
                                value.message and (" **%s**"):format(value.message) or ""
                            ),
                            done = value.kind == "end",
                        }
                        break
                    end
                end
                local msg = {}
                progress[client.id] = vim.tbl_filter(function(v)
                    return table.insert(msg, v.msg) or not v.done
                end, p)

                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(table.concat(msg, "\n"), "info", {
                    id = "lsp_progress",
                    title = client.name,
                    opts = function(notif)
                        notif.icon = #progress[client.id] == 0 and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })

        -- MiniFiles → Snacks rename hook
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        ---------------------------------------------------------
        -- Global debug helpers
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        ---------------------------------------------------------
        -- Toggles
        Snacks.toggle.zen():map("<leader>uz")
        Snacks.toggle.zoom():map("<leader>uZ")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.words():map("<leader>uW")
        Snacks.toggle.scroll():map("<leader>uS")
        Snacks.toggle.option("spell"):map("<leader>us")
        Snacks.toggle.option("wrap"):map("<leader>uw")
        Snacks.toggle.option("relativenumber"):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")

        Snacks.toggle({
            name = "Auto Format global",
            get = function() return vim.g.autoformat end,
            set = function(state) vim.g.autoformat = state end,
        }):map("<leader>uf")

        Snacks.toggle({
            name = "Auto Format buffer",
            get = function() return vim.b.autoformat end,
            set = function(state) vim.b.autoformat = state end,
        }):map("<leader>uF")
    end,
}
