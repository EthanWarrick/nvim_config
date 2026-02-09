---@type LazyPluginSpec
local Plugin = { "saghen/blink.cmp" }

Plugin.version = "1.*" -- use a release tag to download pre-built binaries

Plugin.event = "InsertEnter"

---@module 'blink.cmp'
---@type blink.cmp.Config
Plugin.opts = {
  keymap = {
    preset = "none",
    -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-c>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },

    ["<C-p>"] = { "scroll_documentation_up" },
    ["<C-n>"] = { "scroll_documentation_down" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "normal",
    kind_icons = require("util").icons.kinds,
  },

  completion = {
    list = { selection = { preselect = false, auto_insert = false } },
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },

    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 500 },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = false },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  cmdline = { enabled = false }, -- Disable blink cmdline completions
}

Plugin.opts_extend = { "sources.default" } -- Secret Lazy.nvim spec

Plugin.config = function(_, opts)
  local blink = require("blink.cmp")
  blink.setup(opts)

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities({}, false))
  -- Make sure capabilities are added elsewhere with `capabilities = vim.tbl_deep_extend('force', capabilities, {...})`
end

return Plugin
