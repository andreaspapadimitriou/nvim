return function(opts)
    opts = opts or {}

    local defaults = {
        min_size = 2,
        max_size = nil,
        cursor = true,
        edge = true,
        siblings = false,
        -- what buffers to attach to (keeps the default behavior)
        filter = function(buf)
            return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
        end,
        -- debounce scope detection in ms
        debounce = 30,
        treesitter = {
            enabled = true,
            injections = true,
            blocks = {
                enabled = false,
                "function_declaration",
                "function_definition",
                "method_declaration",
                "method_definition",
                "class_declaration",
                "class_definition",
                "do_statement",
                "while_statement",
                "repeat_statement",
                "if_statement",
                "for_statement",
            },
            field_blocks = { "local_declaration" },
        },
        -- Keymaps used when scope is enabled. You can override these in your config.
        keys = {
            textobject = {
                ii = {
                    min_size = 2,
                    edge = false,
                    cursor = false,
                    treesitter = { blocks = { enabled = false } },
                    desc = "inner scope",
                },
                ai = {
                    cursor = false,
                    min_size = 2,
                    treesitter = { blocks = { enabled = false } },
                    desc = "full scope",
                },
            },
            jump = {
                ["[i"] = {
                    min_size = 1,
                    bottom = false,
                    cursor = false,
                    edge = true,
                    treesitter = { blocks = { enabled = false } },
                    desc = "jump to top edge of scope",
                },
                ["]i"] = {
                    min_size = 1,
                    bottom = true,
                    cursor = false,
                    edge = true,
                    treesitter = { blocks = { enabled = false } },
                    desc = "jump to bottom edge of scope",
                },
            },
        },
    }

    -- Merge defaults with provided opts (opts takes precedence).
    local merged = vim.tbl_deep_extend("force", defaults, opts)

    -- Ensure `enabled` key is present for consistency with other helper modules.
    merged.enabled = opts.enabled == nil and false or opts.enabled

    return merged
end
