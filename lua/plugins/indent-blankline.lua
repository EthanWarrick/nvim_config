---@type LazyPluginSpec
local Plugin = { "lukas-reineke/indent-blankline.nvim" }

Plugin.main = "ibl"

Plugin.event = { "BufReadPost", "BufNewFile" }

---@module "ibl"
---@type ibl.config See :help ibl.setup()
Plugin.opts = {
  enabled = true,
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    highlight = "CursorLineNr",
    include = { node_type = { lua = { "return_statement", "table_constructor" } } },
  },
  indent = {
    char = "│",
    tab_char = "┆",
    highlight = "LineNr",
  },
}

return Plugin
