return {
    root_markers = {
        {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
        },
        ".git",
    },
    filetypes = {
        "python",
    },
    cmd = { "basedpyright-langserver", "--stdio" },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    },
    settings = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "all",
            autoImportCompletions = true,
        },
        disableOrganizeImports = false,
    },

}
