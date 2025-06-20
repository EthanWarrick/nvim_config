---@type LazyPluginSpec
local Snippet_Engine = {
  "L3MON4D3/LuaSnip",
  lazy = true,
  enabled = false,
  -- Only build if not on Windows
  -- jsregexp is optional, so its not a big deal if it fails
  build = (vim.uv.os_uname().sysname:find("Windows") == nil) and "make install_jsregexp" or nil,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      end,
    },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
}

Snippet_Source = { "rafamadriz/friendly-snippets", event = "InsertEnter" }

local BlinkCompletion = {
  "saghen/blink.cmp",
  optional = true,
  opts = {
    snippets = {
      preset = "luasnip",
    },
  },
}

Snippet_Engine.specs = { BlinkCompletion }

return { Snippet_Engine, Snippet_Source }
