---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "css", "javascript", "jsdoc", "tsx", "typescript" },
  },
}

---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "typescript-language-server" },
  },
}
vim.lsp.enable("ts_ls")

return { Treesitter, Mason }
