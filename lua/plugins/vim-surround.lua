---@type LazyPluginSpec
local Plugin = { "kylechui/nvim-surround" }

Plugin.keys = {
  { "<C-g>s", mode = "i" },
  { "<C-g>S", mode = "i" },
  "ys",
  "yss",
  "yS",
  "ySS",
  { "S", mode = "x" },
  { "gS", mode = "x" },
  "ds",
  "cs",
  "cS",
}

Plugin.config = true

return Plugin
