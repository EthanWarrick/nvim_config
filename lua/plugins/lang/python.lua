return {

  -- Treesitter
  require("util").ts_ensure_installed({ "python", "rst" }),

  -- Install Ruff via Mason
  require("util").mason_ensure_installed("ruff"),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- Ensure mason installs the server
        pylsp = {},
        ruff_lsp = {}, -- Additional ruff diagnostics
      },
    },
  },
}
