local Plugin = { "declancm/maximize.nvim" }

Plugin.cmd = "Maximize"

Plugin.keys = {
  { "<leader>z", "<cmd>Maximize<CR>", mode = { "n", "v" }, desc = "Maximize (Zoom) the current window" },
  { "<C-w>z", "<cmd>Maximize<CR>", mode = { "n", "v" }, desc = "Maximize (Zoom) the current window" },
}

Plugin.opts = {}

return Plugin
