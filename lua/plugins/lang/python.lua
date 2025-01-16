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
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_fix" },
    },
  },
}

return { Treesitter, LSP, Formatter }
