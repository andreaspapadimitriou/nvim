local home = os.getenv("HOME")
local fqbn = "arduino:avr:uno"
local cli_config = home .. "/.arduino15/arduino-cli.yaml"

return {
  -- cmd = {
  --   "arduino-language-server",
  --   "-cli", "/usr/local/bin/arduino-cli",
  --   "-cli-config", "/home/ap/.arduino15/arduino-cli.yaml",
  --   "-fqbn", fqbn,
  --   "-clangd", "/usr/local/bin/clangd"
  -- },
cmd = {
    "arduino-language-server",
    "-cli-config",
    "~/.arduino15/arduino-cli.yaml",
    "-cli",
    "arduino-cli",
    "-clangd",
    "clangd",
    "-fqbn",
    "arduino:avr:uno",
  },
  filetypes = { "ino", "cpp", "c","arduino" },
}
