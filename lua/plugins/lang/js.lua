local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "css", "javascript", "jsdoc", "tsx", "typescript" })
    end
  end,
}

local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      -- Ensure mason installs the server
      tsserver = {}, -- Requires Node.js | Might need to update Node.js
    },
  },
}

return { Treesitter, LSP }
