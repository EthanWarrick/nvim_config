local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

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
