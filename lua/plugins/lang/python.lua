---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "python", "rst" },
  },
}

---@module 'mason'
---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = { ---@type MasonSettings
    ensure_installed = { "python-lsp-server", "ruff" },
  },
}

vim.lsp.config("pylsp", { ---@type vim.lsp.Config
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
})
vim.lsp.enable({ "pylsp", "ruff" })

---@module 'conform'
---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  specs = { "williamboman/mason.nvim", opts = { ensure_installed = { "ruff" } } },
  opts = { ---@type conform.setupOpts
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
