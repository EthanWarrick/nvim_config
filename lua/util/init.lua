local M = {}

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
