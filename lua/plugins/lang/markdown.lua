---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "markdown", "markdown_inline" },
  },
}

---@module 'mason'
---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = { ---@type MasonSettings
    ensure_installed = { "marksman" },
  },
}
vim.lsp.enable("marksman")

return { Treesitter, Mason }
