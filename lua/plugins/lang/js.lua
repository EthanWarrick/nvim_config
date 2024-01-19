return {

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
