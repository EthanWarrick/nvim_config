---@module 'nvim-treesitter'
---@type LazyPluginSpec
local Treesitter = { "nvim-treesitter/nvim-treesitter" }

Treesitter.branch = "main"
Treesitter.version = false -- last release is way too old and doesn't work on Windows

Treesitter.build = ":TSUpdate"

Treesitter.event = { "VeryLazy" }

Treesitter.lazy = vim.fn.argc(-1) == 0 -- load treesitter early when opening a file from the cmdline

Treesitter.cmd = { "TSLog", "TSUpdate", "TSInstall", "TSUninstall" }

---@class TSFeatConfig
---@field enable? boolean Enable feature
---@field disable? string[] List of langs to disable feature

---@class TSConfig
---@field highlight? TSFeatConfig
---@field indent? TSFeatConfig
---@field folds? TSFeatConfig
---@field ensure_installed? string[] List of parsers to install

---@type TSConfig
---@diagnostic disable-next-line: missing-fields
Treesitter.opts = {
  install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
  highlight = { enable = true },
  indent = { enable = true },
  folds = { enable = false },
  ensure_installed = {
    "bash",
    "diff",
    "query",
    "regex",
    "vim",
    "vimdoc",
  },
}

Treesitter.opts_extend = { "ensure_installed" } -- Secret Lazy.nvim spec

local _installed = nil ---@type table<string,boolean>?
local _queries = {} ---@type table<string,boolean>

---@param update boolean?
---@return table<string, boolean>
local function get_installed(update)
  if update then
    _installed, _queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      _installed[lang] = true
    end
  end
  return _installed or {}
end

---@param lang string
---@param query string
---@return boolean
local function have_query(lang, query)
  local key = lang .. ":" .. query
  if _queries[key] == nil then
    _queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return _queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
local function have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or get_installed()[lang] == nil then
    return false
  end
  if query and not have_query(lang, query) then
    return false
  end
  return true
end

---@return string
_G.ts_foldexpr = function()
  return have(nil, "folds") and vim.treesitter.foldexpr() or "0"
end

---@return integer
_G.ts_indentexpr = function()
  return have(nil, "indents") and require("nvim-treesitter").indentexpr() or -1
end

---@param opts TSConfig
Treesitter.config = function(_, opts)
  local TS = require("nvim-treesitter")

  -- some quick sanity checks
  if not TS.get_installed then
    return vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
  elseif type(opts.ensure_installed) ~= "table" then
    return vim.notify("`nvim-treesitter` opts.ensure_installed must be a table", vim.log.levels.ERROR)
  end

  -- setup treesitter
  TS.setup(opts)
  get_installed(true) -- initialize the installed langs

  -- install missing parsers
  local install = vim.tbl_filter(function(lang)
    return not have(lang)
  end, opts.ensure_installed or {})
  if #install > 0 then
    TS.install(install, { summary = true }):await(function()
      get_installed(true) -- refresh the installed langs
    end)
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
    callback = function(args)
      local ft, lang = args.match, vim.treesitter.language.get_lang(args.match)
      if not have(ft) then
        return
      end

      ---@param feat string
      ---@param query string
      ---@return boolean
      local function enabled(feat, query)
        local f = opts[feat] or {} ---@type TSFeatConfig
        return f.enable ~= false
          and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
          and have(ft, query)
      end

      -- highlighting
      if enabled("highlight", "highlights") then
        pcall(vim.treesitter.start, args.buf)
      end

      -- indents
      if enabled("indent", "indents") then
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.bo.indentexpr = "v:lua.ts_indentexpr()"
      end

      -- folds
      if enabled("folds", "folds") then
        -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldexpr = "v:lua.ts_foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
      end
    end,
  })
end

local Treesitter_Text_Objects = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  opts = {
    move = {
      enable = true,
      set_jumps = true,
      keys = {
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]g"] = "@comment.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]G"] = "@comment.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[g"] = "@comment.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[G"] = "@comment.outer",
        },
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keys = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ag"] = "@comment.outer",
        ["ig"] = "@comment.inner",
      },
    },
    swap = { enable = false },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter-textobjects")
    if not TS.setup then
      vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
      return
    end
    TS.setup(opts)

    local function attach(buf)
      local ft = vim.bo[buf].filetype
      if vim.tbl_get(opts, "move", "enable") and have(ft, "textobjects") then
        ---@type table<string, table<string, string>>
        local moves = vim.tbl_get(opts, "move", "keys") or {}

        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local queries = type(query) == "table" and query or { query }
            local parts = {}
            for _, q in ipairs(queries) do
              local part = q:gsub("@", ""):gsub("%..*", "")
              part = part:sub(1, 1):upper() .. part:sub(2)
              table.insert(parts, part)
            end
            local desc = table.concat(parts, " or ")
            desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
            desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
            vim.keymap.set({ "n", "x", "o" }, key, function()
              if vim.wo.diff and key:find("[cC]") then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end, {
              buffer = buf,
              desc = desc,
              silent = true,
            })
          end
        end



        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { buf = buf })
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { buf = buf })

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { buf = buf })
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite, { buf = buf })

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, buf = buf })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, buf = buf })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, buf = buf })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, buf = buf })

      end

      if vim.tbl_get(opts, "select", "enable") and have(ft, "textobjects") then
        ---@type table<string, string>
        local selects = vim.tbl_get(opts, "select", "keys") or {}

        for key, query in pairs(selects) do
          local desc = query:gsub("@", ""):gsub("%..*", ""):gsub("^%l", string.upper)
          desc = (key:sub(1, 1) == "i" and "In " or "Around ") .. desc

          vim.keymap.set({ "x", "o" }, key, function()
            if vim.wo.diff and key:find("[cC]") then
              return vim.cmd("normal! " .. key)
            end
            require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
          end, {
            buffer = buf,
            desc = desc,
            silent = true,
          })
        end
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
      callback = function(ev)
        attach(ev.buf)
      end,
    })
    vim.tbl_map(attach, vim.api.nvim_list_bufs())
  end,
}

return { Treesitter, Treesitter_Text_Objects }
