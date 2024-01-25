return {

  -- Treesitter
  require("util").ts_ensure_installed({
    "css",
    "javascript",
    "json",
    "tsx",
    "typescript",
  }),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- Ensure mason installs the server
        tsserver = {}, -- Requires Node.js | Might need to update Node.js
      },
    },
  },
}
