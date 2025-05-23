---@type LazyPluginSpec
local Plugin = { "folke/which-key.nvim" }

Plugin.enabled = true

Plugin.event = "VeryLazy"

Plugin.keys = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Keymaps (which-key)",
  },
  {
    "<c-w><space>",
    function()
      require("which-key").show({ keys = "<c-w>", loop = true })
    end,
    desc = "Window Hydra Mode (which-key)",
  },
}

Plugin.opts_extend = { "spec" }

Plugin.opts = {
  preset = "helix",
  spec = {},
}

return Plugin
