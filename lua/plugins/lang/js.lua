---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "css", "javascript", "jsdoc", "tsx", "typescript" },
  },
}

---@module 'mason'
---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = { ---@type MasonSettings
    ensure_installed = { "typescript-language-server" },
  },
}
vim.lsp.enable("ts_ls")

return { Treesitter, Mason }
