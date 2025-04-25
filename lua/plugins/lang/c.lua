---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "c", "cpp", "make", "rst" },
  },
}

---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "clangd" },
  },
}

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index", -- Index project code in the background
    "--clang-tidy", -- use clang-tidy for code formatting
    "--fallback-style=llvm", -- formatting option if not using clang-tidy
  },
})
vim.lsp.enable("clangd")

---@type LazyPluginSpec
local Linter = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      c = { "checkpatch" },
    },
    ---@type { [string]: ( lint.Linter | {condition: fun(ctx: table): boolean} | {mason: boolean} ) }
    linters = {
      checkpatch = {
        cmd = "./scripts/checkpatch.pl",
        condition = function(_)
          return vim.fn.filereadable("./scripts/checkpatch.pl") == 1
        end,
        mason = false,
      },
    },
  },
}

return { Treesitter, Mason, Linter }
