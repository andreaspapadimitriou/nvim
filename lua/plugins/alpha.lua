return {
    {
        "goolord/alpha-nvim",
        -- dependencies = { "folke/persistence.nvim" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            local function week_ascii_text()
                return {
                    ["Monday"] = [[

            ███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗
            ████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
            ██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝
            ██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝
            ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║
            ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                    ["Tuesday"] = [[

            ████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
            ╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
               ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝
               ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝
               ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║
               ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

        ]],
                    ["Wednesday"] = [[

            ██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
            ██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
            ██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝
            ██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝
            ╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║
             ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                    ["Thursday"] = [[

            ████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗
            ╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
               ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝
               ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝
               ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║
               ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                    ["Friday"] = [[

            ███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗
            ██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝
            █████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝
            ██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝
            ██║     ██║  ██║██║██████╔╝██║  ██║   ██║
            ╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                    ["Saturday"] = [[

            ███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗
            ██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
            ███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝
            ╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝
            ███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║
            ╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                    ["Sunday"] = [[

            ███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
            ██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
            ███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝
            ╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝
            ███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║
            ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝

            ]],
                }
            end

            local function week_header()
                local week = week_ascii_text()
                local daysoftheweek =
                    { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
                local day = daysoftheweek[os.date("*t").wday]
                return week[day] .. "\n"
            end

            -- Projects can be added manually by using the :Telescope project add'
            local purple = "Identifier"
            dashboard.section.header.val = vim.split(week_header(), "\n")
            dashboard.section.header.opts.hl = purple
            dashboard.section.buttons.val = {
                dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  > Find file", ":cd $HOME | Telescope find_files<CR>"),
                dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                -- dashboard.button(
                -- 	"p",
                -- 	"  > Project",
                -- 	":lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>"
                -- ),
                -- this is just a temp fix to load previous stuff since the project did not work
                dashboard.button("p", "  > Project", ":AutoSession search<CR>"),
                -- dashboard.button("p", "  > Select Session", ":lua require('persistence').select()<CR>"),
                dashboard.button("c", "  > Configuration", ":e $MYVIMRC <CR>"),
                dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
            }
            dashboard.section.footer.val = os.date("%Y-%m-%d %H:%M:%S ")
            alpha.setup(dashboard.opts)
        end,
    },
}
