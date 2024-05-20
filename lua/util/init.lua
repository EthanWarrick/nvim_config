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
  return function()
    _G.my_grep = function(mode)
      local regsave = vim.fn.getreg("@")
      local selsave = vim.o.selection
      local selvalid = true

      vim.o.selection = "inclusive"

      if mode == "v" or mode == "V" then
        vim.api.nvim_command('silent execute "normal! gvy"')
      elseif mode == "line" then
        vim.api.nvim_command("silent execute \"normal! '[V']y\"")
      elseif mode == "char" then
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

    vim.o.operatorfunc = "v:lua.my_grep"
    vim.api.nvim_feedkeys("g@", "n", false)
  end
end

M.icons = {
  misc = {
    dots = "󰇘",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    error = "✘ ",
    warn = "▲ ",
    hint = "⚑ ",
    info = "» ",
  },
  git = {
    Added = " ",
    Copied = "C",
    Deleted = " ",
    Ignored = "!",
    Modified = " ",
    Renamed = "R",
    TypeChanged = "T",
    Unmodified = " ",
    Unmerged = "U",
    Untracked = "?",
    External = "X",

    UpstreamAdded = "A",
    UpstreamCopied = "C",
    UpstreamDeleted = "D",
    UpstreamIgnored = "!",
    UpstreamModified = "M",
    UpstreamRenamed = "R",
    UpstreamTypeChanged = "T",
    UpstreamUnmodified = " ",
    UpstreamUnmerged = "U",
    UpstreamUntracked = "?",
    UpstreamExternal = "X",
  },
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

return M
