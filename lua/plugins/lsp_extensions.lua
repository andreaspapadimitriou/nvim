return {
    {
        "artemave/workspace-diagnostics.nvim",
        keys = {
            {
                "<leader>qj",
                function()
                    local skip_clients = {
                        typos_lsp = true,
                        copilot = true,
                    }

                    for _, client in ipairs(vim.lsp.get_clients()) do
                        if not skip_clients[client.name] then
                            local has_filetypes = client.config
                                and client.config.filetypes
                                and #client.config.filetypes > 0
                            if has_filetypes then
                                require("workspace-diagnostics").populate_workspace_diagnostics(
                                    client,
                                    0
                                )
                            end
                        end
                    end
                end,
                desc = "Workspace diagnostics",
            },
        },
    },
}
