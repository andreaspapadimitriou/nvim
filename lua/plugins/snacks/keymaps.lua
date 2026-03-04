-- Snacks keymaps
-- Organized by functionality

return {
    -- Lazygit
    {
        "<leader>gg",
        function()
            Snacks.lazygit()
        end,
        desc = "Lazygit",
    },

    -- Zen mode and Zoom
    {
        "<leader>uz",
        function()
            Snacks.toggle.zen():toggle()
        end,
        desc = "Zen Mode",
    },
    {
        "<leader>uZ",
        function()
            Snacks.toggle.zoom():toggle()
        end,
        desc = "Zoom",
    },

    -- GitHub
    {
        "<leader>Gi",
        function()
            Snacks.picker.gh_issue()
        end,
        desc = "GitHub Issues (open)",
    },
    {
        "<leader>GI",
        function()
            Snacks.picker.gh_issue({ state = "all" })
        end,
        desc = "GitHub Issues (all)",
    },
    {
        "<leader>Gq",
        function()
            Snacks.picker.gh_pr()
        end,
        desc = "GitHub Pull Requests (open)",
    },
    {
        "<leader>GQ",
        function()
            Snacks.picker.gh_pr({ state = "all" })
        end,
        desc = "GitHub Pull Requests (all)",
    },

    -- Quick access
    {
        "<leader>/",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },
    {
        "<leader>:",
        function()
            Snacks.picker.command_history()
        end,
        desc = "Command History",
    },
    {
        "<leader>,",
        function()
            Snacks.picker.buffers()
        end,
        desc = "Buffers",
    },
    {
        "<leader><space>",
        function()
            Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
    },

    -- Find
    {
        "<leader>fn",
        function()
            Snacks.picker.notifications()
        end,
        desc = "Notify",
    },
    {
        "<leader>fb",
        function()
            Snacks.picker.buffers()
        end,
        desc = "Buffers",
    },
    {
        "<leader>fh",
        function()
            Snacks.picker.files({ cwd = vim.fn.expand("$HOME") })
        end,
        desc = "Find home File",
    },
    {
        "<leader>flr",
        function()
            Snacks.picker.lsp_references()
        end,
        desc = "Find LSP References",
    },
    {
        "<leader>flj",
        function()
            Snacks.picker.lsp_implementations()
        end,
        desc = "Find LSP Implementations",
    },
    {
        "<leader>fc",
        function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
    },
    {
        "<leader>ff",
        function()
            Snacks.picker.files()
        end,
        desc = "Find Files",
    },
    {
        "<leader>fg",
        function()
            Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
    },
    {
        "<leader>fr",
        function()
            Snacks.picker.recent()
        end,
        desc = "Recent",
    },
    {
        "<leader>fs",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },

    -- Git
    {
        "<leader>gA",
        function()
            Snacks.picker.git_log()
        end,
        desc = "Log",
    },
    {
        "<leader>ga",
        function()
            Snacks.picker.git_branches()
        end,
        desc = "Branches",
    },
    {
        "<leader>gL",
        function()
            Snacks.picker.git_log_line()
        end,
        desc = "Log Line",
    },

    -- Search/Grep
    {
        "<leader>sb",
        function()
            Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
    },
    {
        "<leader>sB",
        function()
            Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
    },
    {
        "<leader>sD",
        function()
            Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
    },
    {
        "<leader>sg",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },
    {
        "<leader>sw",
        function()
            Snacks.picker.grep_word()
        end,
        mode = { "n", "x" },
        desc = "Visual selection or word",
    },
}
