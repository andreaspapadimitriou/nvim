return {
    "folke/sidekick.nvim",
    opts = {
        -- add any options here
        cli = {
            mux = {
                enabled = false, -- Disabled: uses Neovim's built-in terminal instead
            },
        },
    },
    keys = {
        {
            -- default keybind was tab but conflicts with other bufferline
            "<tab>",
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if not require("sidekick").nes_jump_or_apply() then
                    return "<Tab>" -- fallback to normal tab
                end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<M-.>",
            function()
                 require("sidekick.cli").toggle({ name = "copilot", focus = false })
            end,
            desc = "Sidekick Toggle",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>is",
            function()
                require("sidekick.cli").select()
            end,
            -- Or to select only installed tools:
            -- require("sidekick.cli").select({ filter = { installed = true } })
            desc = "Select CLI",
        },
        {
            "<leader>id",
            function()
                require("sidekick.cli").close()
            end,
            desc = "Detach a CLI Session",
        },
        {
            "<leader>ix",
            function()
                require("sidekick.cli").send({ msg = "{this}" })
            end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>if",
            function()
                require("sidekick.cli").send({ msg = "{file}" })
            end,
            desc = "Send File",
        },
        {
            "<leader>iv",
            function()
                require("sidekick.cli").send({ msg = "{selection}" })
            end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<leader>ip",
            function()
                require("sidekick.cli").prompt()
            end,
            mode = { "n", "x" },
            desc = "Prompt actions",
        },
        -- Example of a keybinding to open Claude directly
        {
            "<leader>it",
            function()
                require("sidekick.cli").toggle({ name = "copilot", focus = true })
            end,
            desc = "Toggle Copilot",
        },
        -- NES (Next Edit Suggestions) keymaps - uppercase versions of copilot.lua suggestion keymaps
        {
            "<M-A>", -- uppercase of <M-a> (accept)
            function()
                require("sidekick.nes").apply()
            end,
            mode = { "n", "i" },
            desc = "NES Apply Edit",
        },
        {
            "<M-}>", -- uppercase of <M-]> (next)
            function()
                require("sidekick.nes").jump()
            end,
            mode = { "n", "i" },
            desc = "NES Jump to Next Edit",
        },
        {
            "<M-{>", -- uppercase of <M-[> (prev) - used for refresh
            function()
                require("sidekick.nes").update()
            end,
            mode = { "n", "i" },
            desc = "NES Request Update",
        },
        {
            "<C-}>", -- uppercase of <C-]> (dismiss)
            function()
                require("sidekick.nes").clear()
            end,
            mode = { "n", "i" },
            desc = "NES Clear/Dismiss",
        },
        {
            "<M-T>", -- toggle NES on/off
            function()
                require("sidekick.nes").toggle()
            end,
            mode = { "n" },
            desc = "NES Toggle",
        },
    },
}
