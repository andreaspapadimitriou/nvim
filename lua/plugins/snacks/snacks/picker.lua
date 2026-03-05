return function(opts)
    return {
        enabled = opts.enabled or false,
        previewers = {
            diff = {
                cmd = { "delta" },
            },
        },
        formatters = {
            file = {
                filename_first = true,
                truncate = 40,
            },
        },
        sources = {
            buffers = {
                title = "Buffers (<ctrl-d> to close)",
                win = {
                    input = {
                        keys = {
                            ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                        },
                    },
                },
                actions = {
                    bufdelete = function(picker, item)
                        if item then
                            vim.api.nvim_buf_delete(item.buf, { force = false })
                            picker:find()
                        end
                    end,
                },
            },
            grep = {
                title = "Grep (<ctrl-g> to Regex)",
                win = {
                    input = {
                        keys = {
                            ["<c-g>"] = { "toggle_regex", mode = { "n", "i" } },
                        },
                    },
                },
                actions = {
                    toggle_regex = function(picker)
                        picker.opts.regex = not picker.opts.regex
                        local title = picker.opts.regex and "Grep (<ctrl-g> to Fuzzy)"
                            or "Grep (<ctrl-g> to Regex)"
                        picker:set_title(title)
                        picker:find()
                    end,
                },
            },
        },
    }
end
