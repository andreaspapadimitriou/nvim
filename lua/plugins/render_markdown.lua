return {
    -- This plugin renders markdown files with enhanced styling
    -- As for now, it does not render images and might be related to 
    -- the lack of terminal support for it.
    "MeanderingProgrammer/render-markdown.nvim",
    -- cmd = { "RenderMarkdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },

    init = function()
        -- Get Catppuccin Mocha colors
        local colors = require("catppuccin.palettes").get_palette("mocha")
        
        local color1_bg = colors.red
        local color2_bg = colors.peach
        local color3_bg = colors.yellow
        local color4_bg = colors.sapphire
        local color5_bg = colors.teal
        local color6_bg = colors.mauve

        -- Define text (foreground) colors
        local text_color = colors.base -- Dark background color for text

        -- Background colors for headings
        vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], text_color, color1_bg))
        vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], text_color, color2_bg))
        vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], text_color, color3_bg))
        vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], text_color, color4_bg))
        vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], text_color, color5_bg))
        vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], text_color, color6_bg))

        -- Bold text for icons or additional elements within headings
        vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
        vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
        vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
        vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
        vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
        vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))

    end,
    opts = {
        heading = {
            sign = true,

            completions = {
                  blink = { enabled = false }
            },
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
                    sign = {
            -- Turn on / off sign rendering.
            enabled = true,
            -- Applies to background of sign text.
            highlight = 'RenderMarkdownSign',
        },
        inline_highlight = {
            -- Mimics Obsidian inline highlights when content is surrounded by double equals.
            -- The equals on both ends are concealed and the inner content is highlighted.
    
            -- Turn on / off inline highlight rendering.
            enabled = true,
            -- Additional modes to render inline highlights.
            render_modes = false,
            -- Applies to background of surrounded text.
            highlight = 'RenderMarkdownInlineHighlight',
            -- Define custom highlights based on text prefix.
            -- The key is for healthcheck and to allow users to change its values, value type below.
            -- | prefix    | matched against text body, @see :h vim.startswith() |
            -- | highlight | highlight for text body                             |
            custom = {},
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
