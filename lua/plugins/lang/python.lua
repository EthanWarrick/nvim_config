return {

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
