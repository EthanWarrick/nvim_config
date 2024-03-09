return {

  -- Treesitter
  require("util").ts_ensure_installed({ "bitbake" }),

  -- Linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        bitbake = { "oelint-adv" },
      },
    },
  },
}
