---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { "json", "json5", "jsonc" },
  },
}

-- SchemaStore is a universal JSON schema store, where schemas for popular JSON documents can be found.
---@type LazyPluginSpec
local Extra = {
  "b0o/schemastore.nvim",
  lazy = true,
}

---@module 'mason'
---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = { ---@type MasonSettings
    ensure_installed = { "json-lsp" },
  },
}

vim.lsp.config("jsonls", { ---@type vim.lsp.Config
  -- lazy-load schemastore when needed
  before_init = function(_, new_config)
    new_config.settings.json.schemas =
      vim.tbl_deep_extend("force", new_config.settings.json.schemas or {}, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
})
vim.lsp.enable("jsonls")

return { Treesitter, Mason, Extra }
