---@type LazyPluginSpec
local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.enabled = false

Plugin.dependencies = {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}

Plugin.event = "InsertEnter"

Plugin.cmd = "CmpStatus"

Plugin.opts = function()
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
  -- TODO: References to luasnip should be moved.
  local luasnip = require("luasnip")

  ---@type cmp.ConfigSchema
  return {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),
    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind", "menu" },
      format = function(_, item)
        local icons = require("util").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          if luasnip.expandable() then
            luasnip.expand()
          else
            cmp.confirm({
              select = false,
            }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          end
        else
          fallback()
        end
      end),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-c>"] = cmp.mapping.abort(),
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  }
end

---@param opts cmp.ConfigSchema
function Plugin.config(_, opts)
  for _, source in ipairs(opts.sources) do
    source.group_index = source.group_index or 1
  end
  require("cmp").setup(opts)
end

return Plugin
