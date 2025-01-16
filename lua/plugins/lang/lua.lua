---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "lua", "luadoc", "luap" },
  },
}

---@type LazyPluginSpec
local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  dependencies = { "folke/neodev.nvim", config = true },
  opts = {
    servers = {
      -- Ensure mason installs the server
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },
  },
}

-- Formatter
---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
}

return { Treesitter, LSP, Formatter }
