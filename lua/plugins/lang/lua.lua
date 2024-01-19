return {

	-- LSP
	{
		"neovim/nvim-lspconfig",
    optional = true,
    dependencies = { "folke/neodev.nvim", opts = {}, },
		opts = {
			servers = {
				-- Ensure mason installs the server
				lua_ls = {},
      },
    },
  },

}
