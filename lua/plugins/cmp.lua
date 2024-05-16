---@type LazyPluginSpec
local Plugin = { "hrsh7th/nvim-cmp" }

Plugin.dependencies = {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}

Plugin.event = "InsertEnter"

Plugin.opts = function()
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
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

-- I'm not for sure if LuaSnip should be a dependency of nvim-cmp or not
-- Right now it can't be a dependency, because nvim-cmp's opts function
-- needs to run before the opts function supplied by the nvim-cmp as a
-- LuaSnip dependency.
---@type LazyPluginSpec
local Snippets = {
  "L3MON4D3/LuaSnip",
}

Snippets.lazy = true

-- Only build if not on Windows
Snippets.build = (vim.uv.os_uname().sysname:find("Windows") == nil) and "make install_jsregexp" or nil

Snippets.dependencies = {
  {
    "nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "luasnip" })
    end,
  },
}

Snippets.opts = {
  history = true,
  delete_check_events = "TextChanged",
}

return { Plugin, Snippets }
