---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "bash" },
  },
}

---@type LazyPluginSpec
local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      bash = { "shellcheck" },
      sh = { "shellcheck" },
    },
  },
}

return { Treesitter, Linter }
