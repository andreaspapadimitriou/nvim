local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"echasnovski/mini.icons"  },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {
                        left = icons.separator.line.left,
                        right = icons.separator.line.right,
                    },
                    section_separators = {
                        left = icons.separator.full.left,
                        right = icons.separator.full.right,
                    },
                    disabled_filetypes = {
                        statusline = {
                            "dashboard",
                            "lazy",
                            "Mason",
                        },
                        winbar = { "Trouble", "lazy" },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_c = {},
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress", "location" },
                    lualine_z = {
                        function()
                            return icons.misc.clock .. os.date("%B %d, %H:%M")
                        end,
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {
                        {
                            function()
                                return icons.misc.clock .. os.date(" %B %d, %H:%M")
                            end,
                        },
                    },
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}
