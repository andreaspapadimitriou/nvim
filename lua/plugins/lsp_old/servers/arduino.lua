local home = os.getenv("HOME")
local fqbn = "esp32:esp32:esp32" -- Change to your actual board if needed
local cli_config = home .. "/.arduino15/arduino-cli.yaml"

return {
    cmd = {
        "arduino-language-server",
        "-cli-config",
        cli_config,
        "-cli",
        "arduino-cli",
        "-clangd",
        "clangd",
        "-fqbn",
        fqbn,
    },
    filetypes = { "ino", "cpp", "c", "arduino" },
}
