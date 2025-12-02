---@type LazyPluginSpec
local Mason = {
  "williamboman/mason.nvim",
  optional = true,
  opts = {
    ensure_installed = { "copilot-language-server" },
  },
}
vim.lsp.enable("copilot")

---@type LazyPluginSpec
local BlinkCompletionSrc = {
  "fang2hou/blink-copilot",
  -- Make sure Copilot LSP is installed as completion source
  cond = (vim.fn.executable("copilot-language-server") == 1)
    or (vim.fn.executable(vim.fn.stdpath("data") .. "/mason/bin/copilot-language-server") == 1),
  lazy = true,
  opts = function()
    local icon = require("util").icons.kinds.Copilot
    return {
      max_completions = 3,
      max_attempts = 4,
      kind_name = "Copilot", ---@type string | false
      kind_icon = icon, ---@type string | false
      kind_hl = false, ---@type string | false
      debounce = 200, ---@type integer | false
      auto_refresh = {
        backward = true,
        forward = true,
      },
    }
  end,
}

---@type LazyPluginSpec
local BlinkCompletion = {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "fang2hou/blink-copilot" },
  opts = {
    sources = {
      default = { "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}

-- Don't edit Blink.cmp plugin spec if the Copilot LSP isn't installed
BlinkCompletionSrc.specs = { BlinkCompletion }

return { Mason, BlinkCompletionSrc }
