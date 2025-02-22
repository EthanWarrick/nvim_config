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

-- local LSP = {
--   "Freed-Wu/bitbake-language-server",
--   -- build = "pip3.12 install .",
--   build = "pip3.12 install bitbake-language-server",
--   ft = "bitbake",
--   -- init = function()
--   --   -- Set conf files as bitbake filetypes
--   --   -- pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
--   -- end,
--   config = function()
--     vim.api.nvim_create_autocmd({ "BufEnter" }, {
--       pattern = { "*.bb", "*.bbappend", "*.bbclass", "*.inc", "conf/*.conf" },
--       callback = function()
--         vim.lsp.start({
--           name = "bitbake",
--           cmd = { "bitbake-language-server" },
--         })
--       end,
--     })
--   end,
-- }

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
