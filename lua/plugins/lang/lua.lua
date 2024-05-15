local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
    end
  end,
}

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
