-- File: plugins/telescope/ui.lua
local M = {}

M.layouts = {
    vertical = {
        mirror = false,
    },
    center = {
        preview_cutoff = 40,
    },
    horizontal = {
        prompt_position = "bottom",
        preview_cutoff = 120,
        preview_width = 0.55,
    },
    flex = {
        flip_columns = 140,
    },
    cursor = {
        preview_cutoff = 20,
    },
    small_cursor = {
        width = 0.5,
        height = 0.4,
    },
    lsp = {

        horizontal = {
            preview_cutoff = 150,
            preview_width = 100,
            height = 0.9,
            width = 180,
        },
        vertical = {
            height = 0.8,
            width = 160,
            preview_cutoff = 30,
            preview_height = 0.7,
            mirror = false,
        },
    },
}

M.borderchars = {
    "─",
    "│",
    "─",
    "│",
    "╭",
    "╮",
    "╯",
    "╰",
}

return M
