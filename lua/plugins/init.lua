---@type LazyPluginSpec[]
local Plugins = {
  { "wellle/targets.vim", event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      { "gc", mode = { "n", "x" } },
      { "gb", mode = { "n", "x" } },
      { "gbA", function() require("Comment.api").insert.blockwise.eol({ padding = true }) end, desc = "Block comment at end of line" },
      { "gbo", function() require("Comment.api").insert.blockwise.below({ padding = true }) end, desc = "Block comment below line" },
      { "gbO", function() require("Comment.api").insert.blockwise.above({ padding = true }) end, desc = "Block comment above line" },
    },
  },
}

return Plugins
