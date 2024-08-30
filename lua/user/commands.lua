local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd("BufLeave", {
  desc = "Save window view position",
  group = group,
  callback = function()
    vim.api.nvim_exec2(
      [[
      if !exists("w:SavedBufView")
          let w:SavedBufView = {}
      endif
      let w:SavedBufView[bufnr("%")] = winsaveview()
      ]],
      {}
    )
  end,
})

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Restore window view position",
  group = group,
  callback = function()
    vim.api.nvim_exec2(
      [[
      let buf = bufnr("%")
      if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
          let v = winsaveview()
          let atStartOfFile = v.lnum == 1 && v.col == 0
          if atStartOfFile && !&diff
              call winrestview(w:SavedBufView[buf])
          endif
          unlet w:SavedBufView[buf]
      endif
      ]],
      {}
    )
  end,
})

-- Use relative line numbers on the focused window if in normal mode.
-- If in insert mode or the window is unfocused, use absolute line numbers.
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.statuscolumn = '%s%C%=%{%v:relnum?"%r":"%0"..(float2nr(log10(line("$")))+1).."l"%} '
  end,
  group = numbertogglegroup,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt.statuscolumn = "%=%l "
  end,
  group = numbertogglegroup,
})
