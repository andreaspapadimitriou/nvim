return {
    {
        "willem-J-an/adopure.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            preferred_remotes = {
                "https://dev.azure.com/EPIROC-AUTOMATION",
            },
        },
        config = function(_, opts)

            local azure_token = os.getenv("AZURE_TOKEN")
            assert(azure_token, "No AZURE_TOKEN found in environment variables. Set AZURE_TOKEN to your Azure DevOps Personal Access Token.")

            vim.g.adopure = vim.tbl_extend("force", opts, {
                pat_token = azure_token,
            })

            local function set_keymap(keymap, command)
                vim.keymap.set({ "n", "v" }, keymap, function()
                    vim.cmd(command)
                end, { desc = command })
            end

            set_keymap("<leader>Alc", "AdoPure load context")
            set_keymap("<leader>Alt", "AdoPure load threads")
            set_keymap("<leader>Adq", "AdoPure open quickfix")
            set_keymap("<leader>Aot", "AdoPure open thread_picker")
            set_keymap("<leader>Aon", "AdoPure open new_thread")
            set_keymap("<leader>Aoe", "AdoPure open existing_thread")
            set_keymap("<leader>Asc", "AdoPure submit comment")
            set_keymap("<leader>Asv", "AdoPure submit vote")
            set_keymap("<leader>Ast", "AdoPure submit thread_status")
        end,
    },
}
