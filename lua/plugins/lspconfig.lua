---@type LazyPluginSpec
local Plugin = { "neovim/nvim-lspconfig" }

Plugin.cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" }
Plugin.event = { "BufReadPre", "BufNewFile" }

return Plugin
