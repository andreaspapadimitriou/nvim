return {
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })
        end,
    },
    {

        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        opts = {
            custom_surroundings = {
                ["("] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
                ["["] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
                ["{"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
                ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

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

    {

        "echasnovski/mini.icons",
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                -- needed since it will be false when loading and mini will fail
                package.loaded["nvim-web-devicons"] = {}
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}
