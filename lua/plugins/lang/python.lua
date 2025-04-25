---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "python", "rst" },
  },
}

---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "python-lsp-server", "ruff" },
  },
}

vim.lsp.config("pylsp", {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
})
vim.lsp.enable({ "pylsp", "ruff" })

---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  specs = { "williamboman/mason.nvim", opts = { ensure_installed = { "ruff" } } },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_fix" },
    },
    formatters = {
      ruff_format = {
        mason = false,
      },
      ruff_fix = {
        mason = false,
      },
    },
  },
}

return { Treesitter, Mason, Formatter }
