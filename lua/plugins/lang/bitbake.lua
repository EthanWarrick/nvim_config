---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "bitbake" })
    end
  end,
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

return { Treesitter, Linter }
