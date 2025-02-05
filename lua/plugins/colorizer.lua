---@type LazyPluginSpec
local Plugin = { "norcalli/nvim-colorizer.lua" }

Plugin.cmd = {
  "ColorizerAttachToBuffer",
  "ColorizerDetachFromBuffer",
  "ColorizerReloadAllBuffers",
  "ColorizerToggle",
}

Plugin.opts = {}

return Plugin
