---@type LazyPluginSpec
local Plugin = { "lukas-reineke/indent-blankline.nvim" }

Plugin.main = "ibl"

Plugin.event = { "BufReadPost", "BufNewFile" }

-- See :help ibl.setup()
Plugin.opts = {
  enabled = true,
  scope = {
    enabled = true,
  },
  indent = {
    -- char = "▏",
    char = "│",
    tab_char = "┆",
    highlight = "IblWhitespace",
  },
}

return Plugin
