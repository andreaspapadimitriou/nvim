return {
    {
        "mbbill/undotree",
        config = function()
            local wk = require("which-key")
            wk.add({
                {
                    "<leader>U",
                    "<cmd>UndotreeToggle<cr>",
                    desc = "Undotree",
                    mode = { "n" },
                },
            })
        end,
    },
}
