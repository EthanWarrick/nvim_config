---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "bash" },
  },
}

---@module 'lint'
---@type LazyPluginSpec
local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    ---@type table<string, string[]>
    linters_by_ft = {
      bash = { "shellcheck" },
      sh = { "shellcheck" },
    },
  },
}

return { Treesitter, Linter }
