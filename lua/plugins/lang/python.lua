return {

	-- LSP
	{
		"neovim/nvim-lspconfig",
    optional = true,
		opts = {
			servers = {
				-- Ensure mason installs the server
				 pylsp = {},
			},
		},
	},

}
