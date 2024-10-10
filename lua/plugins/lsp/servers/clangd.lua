local number_of_cores = 4
--if not _G.IS_WINDOWS or _G.IS_WSL then
--    number_of_cores = math.floor(tonumber(vim.fn.system("nproc")) * 0.5)
--end
if _G.external then
  print("External")
end
local paths = require('paths')
--print("Query Driver: " .. paths.query_driver)
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
--        "-j=" .. tostring(number_of_cores),
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
--        "--query-driver=" .. "/opt/sdks/**/*linux-g++",
--        "--query-driver=opt/sdks/rcsos-2.4.0/x86_4.4.50-rt63/sysroots/x86_64-rcssdk-linux/usr/bin/i586-rcs-linux/i586-rcs-linux-g++",
        "--query-driver=" .. paths.query_driver,
        "--header-insertion=iwyu",
    },
}
