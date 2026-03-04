return {
    -- Better `vim.notify()`
    -- {
    --     "rcarriga/nvim-notify",
    --     keys = {
    --         {
    --             "<leader>un",
    --             function()
    --                 require("notify").dismiss({ silent = true, pending = true })
    --             end,
    --             desc = "Dismiss All Notifications",
    --         },
    --     },
    --     opts = {
    --         stages = "static",
    --         timeout = 6000,
    --         max_height = function()
    --             return math.floor(vim.o.lines * 0.75)
    --         end,
    --         max_width = function()
    --             return math.floor(vim.o.columns * 0.75)
    --         end,
    --         on_open = function(win)
    --             vim.api.nvim_win_set_config(win, { zindex = 100 })
    --         end,
    --     },
    --     init = function()
    --         -- when noice is not enabled, install notify on VeryLazy
    --         --    if not LazyVim.has 'noice.nvim' then
    --         --    LazyVim.on_very_lazy(function()
    --         vim.notify = require("notify")
    --         --  end)
    --         --end
    --     end,
    -- },
    -- Cmdline and search UI
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            routes = {
                -- Route all messages to the history, don't display
                {
                    filter = { event = "msg_show" },
                    opts = { skip = true },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentatiqon"] = false,
                },
                hover = { enabled = false },
                signature = { enabled = false },
            },
            presets = {
                bottom_search = true, -- search UI at bottom
                command_palette = false, -- disable command palette
                long_message_to_split = false, -- don't split long messages
                inc_rename = false,
                lsp_doc_border = false,
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 10, -- distance from top
                        col = math.floor(vim.o.columns / 2) - 60 / 2, -- distance from left
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },
        },
        config = function(_, opts)
            if vim.o.filetype == "lazy" then
                vim.cmd([[messages clear]])
            end
            require("noice").setup(opts)
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        keys = {
            { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
            { "<Leader><Tab>", "<Cmd>tabnext<CR>", desc = "next tab" },
        },

        opts = {
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead of buffers
                numbers = "ordinal", -- "none" | "ordinal" | "buffer_id"
                buffer_close_icon = "󰅖",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
                color_icons = true,
            },
        },
    },
}
