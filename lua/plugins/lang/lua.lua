return {

  -- Install Stylua via Mason
  require("util").mason_ensure_installed("stylua"),

  -- LSP
  {
    "neovim/nvim-lspconfig",
    optional = true,
    dependencies = { "folke/neodev.nvim", opts = {} },
    opts = {
      servers = {
        -- Ensure mason installs the server
        lua_ls = {},
      },
    },
  },
}
