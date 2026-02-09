---@type LazyPluginSpec
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  opts = {
    ensure_installed = { "lua", "luadoc", "luap" },
  },
}

---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "lua-language-server" },
  },
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        pathStrict = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable("lua_ls")

-- Formatter
---@type LazyPluginSpec
local Formatter = {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
}

---@type LazyPluginSpec
local BlinkCompletion = {
  "saghen/blink.cmp",
  optional = true,
  opts = {
    sources = {
      default = { "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
}

---@module 'lazydev'
---@type LazyPluginSpec
local Extra = {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  cmd = "LazyDev",
  specs = { BlinkCompletion },
  ---@type lazydev.Config
  opts = {
    library = {
      "lazy.nvim", -- Load Lazy.nvim types. Ex: LazyPluginSpec
      { path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- Load luvit types when the `vim.uv` word is found
    },
  },
}

return { Treesitter, Mason, Formatter, Extra }
