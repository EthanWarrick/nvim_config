return {

  -- Treesitter
  require("util").ts_ensure_installed({ "lua" }),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    dependencies = { "folke/neodev.nvim", config = true },
    opts = {
      servers = {
        -- Ensure mason installs the server
        lua_ls = {},
      },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
