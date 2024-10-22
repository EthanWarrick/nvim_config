---@type LazyPluginSpec[]
local Plugins = {
  { "wellle/targets.vim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", config = true, keys = { { "gc", mode = { "n", "x" } }, { "gb", mode = { "n", "x" } } } },
}

return Plugins
