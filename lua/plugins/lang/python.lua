return {

  -- Treesitter
  require("util").ts_ensure_installed({ "python", "rst" }),

  -- LSP
  {
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
        ruff_lsp = {}, -- Additional ruff diagnostics
      },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}
