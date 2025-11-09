return {
    "MeanderingProgrammer/render-markdown.nvim",
    -- cmd = { "RenderMarkdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },

    init = function()
        local color1_bg = "#b4befe"
        local color2_bg = "#89b4fa"
        local color3_bg = "#74c7ec"
        local color4_bg = "#89dceb"
        local color5_bg = "#94e2d5"
        local color6_bg = "#cba6f7"
        local color_fg = "#f5c2e7"

        -- Define text (foreground) colors
        local text_color1 = "#11111b" -- Red text for heading 1
        local text_color2 = "#11111b" -- Green text for heading 2
        local text_color3 = "#11111b" -- Blue text for heading 3
        local text_color4 = "#11111b" -- Yellow text for heading 4
        local text_color5 = "#11111b" -- Magenta text for heading 5
        local text_color6 = "#11111b" -- Cyan text for heading 6

        -- Background colors for headings
        vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], text_color1, color1_bg))
        vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], text_color2, color2_bg))
        vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], text_color3, color3_bg))
        vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], text_color4, color4_bg))
        vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], text_color5, color5_bg))
        vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], text_color6, color6_bg))

        -- Bold text for icons or additional elements within headings
        vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], text_color1))
        vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], text_color2))
        vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], text_color3))
        vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], text_color4))
        vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], text_color5))
        vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], text_color6))

        -- Add a custom color for emphasized text
        local emphasis_color = "#8caaee" -- Change to your preferred color

        -- Define emphasis text color
        vim.cmd(string.format([[highlight markdownItalic guifg=%s]], emphasis_color))
        vim.cmd(string.format([[highlight markdownBold guifg=%s]], emphasis_color))
        vim.cmd(string.format([[highlight markdownBoldItalic guifg=%s]], emphasis_color))
    end,
    opts = {

        heading = {
            sign = false,
            icons = { " ", " ", " ", " ", " ", " " },
            backgrounds = {
                "Headline1Bg",
                "Headline2Bg",
                "Headline3Bg",
                "Headline4Bg",
                "Headline5Bg",
                "Headline6Bg",
            },
            foregrounds = {
                "Headline1Fg",
                "Headline2Fg",
                "Headline3Fg",
                "Headline4Fg",
                "Headline5Fg",
                "Headline6Fg",
            },
        },
    },
    config = function(_, opts)
        require("render-markdown").setup(opts)
        local wk = require("which-key")
        wk.add({
            {
                "<leader>tm",
                "<cmd>RenderMarkdown toggle<cr>",
                desc = "Toggle RenderMarkdown",
                mode = { "n" },
            },
        })
    end,
}
