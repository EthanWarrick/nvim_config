local M = {}

function M.ts_ensure_installed(ensure)
  return {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      for _, e in pairs(ensure) do
        if not require("util").list_contains(opts.ensure_installed, e) then
          table.insert(opts.ensure_installed, e)
        end
      end
    end,
  }
end

function M.mason_ensure_installed(ensure)
  return {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(ensure) == "string" then
        ensure = { ensure }
      end
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, ensure)
    end,
  }
end

function M.list_contains(list, element)
  if not list then
    return false
  end

  for _, e in pairs(list) do
    if e == element then
      return true
    end
  end

  return false
end

function M.grep_operator(callback)
  local set_opfunc = vim.fn[vim.api.nvim_exec(
    [[
      func s:set_opfunc(val)
        let &opfunc = a:val
      endfunc
      echon get(function('s:set_opfunc'), 'name')
    ]],
    true
  )]

  return function()
    local op = function(t, ...)
      local regsave = vim.fn.getreg("@")
      local selsave = vim.o.selection
      local selvalid = true

      vim.o.selection = "inclusive"

      if t == "v" or t == "V" then
        vim.api.nvim_command('silent execute "normal! gvy"')
      elseif t == "line" then
        vim.api.nvim_command("silent execute \"normal! '[V']y\"")
      elseif t == "char" then
        vim.api.nvim_command('silent execute "normal! `[v`]y"')
      else
        selvalid = false
      end

      vim.o.selection = selsave
      if selvalid then
        local query = vim.fn.getreg("@")
        callback(query)
      end

      vim.fn.setreg("@", regsave)
    end

    set_opfunc(op)
    vim.api.nvim_feedkeys("g@", "n", false)
  end
end

return M
