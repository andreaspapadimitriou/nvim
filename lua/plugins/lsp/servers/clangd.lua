-- local number_of_cores = 4
-- if not _G.IS_WINDOWS or _G.IS_WSL then
--    number_of_cores = math.floor(tonumber(vim.fn.system("nproc")) * 0.5)
-- end

return {
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
    },
    cmd = {
        "clangd",
        -- "-j=" .. tostring(number_of_cores),
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
        "--query-driver=" .. "/opt/sdks/**/*linux-g++",
        -- "--query-driver=" .. "/usr/bin/g++",
        "--header-insertion=iwyu",
    },
}
