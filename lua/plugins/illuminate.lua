return {
    "RRethy/vim-illuminate",
    config = function()
        vim.g.Illuminate_delay = 100
        vim.g.Illuminate_ftblacklist = { "NvimTree", "packer", "dashboard" }
        vim.g.Illuminate_ftwhitelist = {
            "lua",
            "vim",
            "typescript",
            "javascript",
            "typescriptreact",
            "javascriptreact",
            "cpp",
            "py",
        }
        vim.g.Illuminate_providers = { "lsp", "treesitter", "regex" }
        local wk = require("which-key")
        wk.add({
            {
                "<leader>hi",
                "<cmd>IlluminateToggle<cr>",
                desc = "Toggle highlight",
                mode = "n",
            },
        })
    end,
}
