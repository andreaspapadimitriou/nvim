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
        "ino",
    },
    cmd = {
        "clangd",
        -- "-j=" .. tostring(number_of_cores),
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
        --"--query-driver=" .. "/opt/sdks/**/*linux-g++",
        "--query-driver=" .. "/usr/bin/g++",
        -- "--extra-arg=-isystem/usr/include/c++/11",
        "--header-insertion=iwyu",
        "--extra-arg=-I/home/$USER/.arduino15/packages/esp32/hardware/esp32/2.0.7/cores/esp32",
        "--extra-arg=-I/home/$USER/.arduino15/packages/esp32/hardware/esp32/2.0.7/variants/esp32",
        "--extra-arg=-DARDUINO=10805",
        "--extra-arg=-DESP32",
    },
}
