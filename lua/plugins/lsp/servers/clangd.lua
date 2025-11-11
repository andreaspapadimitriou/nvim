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
    -- cmd = {
    --     "clangd",
    --     -- "-j=" .. tostring(number_of_cores),
    --     "--background-index=true",
    --     "--clang-tidy",
    --     "--completion-style=detailed",
    --     "--malloc-trim",
    --     "--all-scopes-completion=true",
    --     -- "--query-driver=" .. "/opt/sdks/**/*linux-g++",
    --     "--query-driver=/home/ap/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp32-elf-gcc",
    --     -- "--query-driver=" .. "/usr/bin/g++",
    --     "--header-insertion=iwyu",
    -- },

    cmd = {
        "/home/ap/.espressif/tools/esp-clang/esp-19.1.2_20250312/esp-clang/bin/clangd", -- Use the same clangd as VSCode
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
        "--query-driver=/home/ap/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp32-elf-gcc",
        "--header-insertion=iwyu",
    },
}
