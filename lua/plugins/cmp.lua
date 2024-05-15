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
  return {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),
    formatting = {
      format = function(_, item)
        local icons = require("util").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    }),
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  }
end

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
local Snippets = {
  "L3MON4D3/LuaSnip",
}
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
Snippets.keys = {
  {
    "<tab>",
    function()
      return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    end,
    expr = true,
    silent = true,
    mode = "i",
    desc = "Jump in snippet",
  },
  {
    "<tab>",
    function()
      require("luasnip").jump(1)
    end,
    mode = "s",
    desc = "Jump in snippet",
  },
  {
    "<s-tab>",
    function()
      require("luasnip").jump(-1)
    end,
    mode = { "i", "s" },
    desc = "Jump back in snippet",
  },
}

return { Plugin, Snippets }
