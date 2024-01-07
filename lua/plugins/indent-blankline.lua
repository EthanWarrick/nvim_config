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
    char = "▏",
  },
}

return Plugin
