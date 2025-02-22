---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "bitbake" },
  },
}

---@type LazyPluginSpec
local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  -- Force mason to install the LSP
  specs = { "williamboman/mason.nvim", opts = { ensure_installed = { "language-server-bitbake" } } },
  opts = {
    servers = {
      -- Ensure mason installs the server
      bitbake_ls = { mason = false }, -- Official Bitbake Language Server for the Yocto Project.
      -- bitbake_language_server = {}, -- Language server for bitbake (Freed-Wu)
    },
  },
}

---@type LazyPluginSpec
local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      bitbake = { "oelint-adv" },
    },
  },
}

return { Treesitter, LSP, Linter }
