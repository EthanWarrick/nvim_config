---@type LazyPluginSpec
local Plugin = { "norcalli/nvim-colorizer.lua" }

Plugin.event = "VeryLazy"

Plugin.cmd = {
  "ColorizerAttachToBuffer",
  "ColorizerDetachFromBuffer",
  "ColorizerReloadAllBuffers",
  "ColorizerToggle",
}

Plugin.opts = { "*" }

return Plugin
