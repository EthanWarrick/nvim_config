local Treesitter = require("util").ts_ensure_installed({ "json", "json5", "jsonc" })

-- SchemaStore is a universal JSON schema store, where schemas for popular JSON documents can be found.
local Extra = {
  "b0o/schemastore.nvim",
  lazy = true,
}

local LSP = {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },
    },
  },
}

return { Treesitter, LSP, Extra }