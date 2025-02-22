---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "python", "rst" },
  },
}

---@type LazyPluginSpec
local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      -- Ensure mason installs the server
      pylsp = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      },
      ruff = {}, -- Additional ruff diagnostics
    },
  },
}

---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  specs = { "williamboman/mason.nvim", opts = { ensure_installed = { "ruff" } } },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_fix" },
    },
    formatters = {
      ruff_format = {
        mason = false,
      },
      ruff_fix = {
        mason = false,
      },
    }
  },
}

return { Treesitter, LSP, Formatter }
