local Treesitter = require("util").ts_ensure_installed({ "lua" })

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
