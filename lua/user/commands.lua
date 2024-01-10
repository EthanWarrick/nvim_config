local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- TODO: this should be coverted to lua
-- This ports over ctags functionality
vim.api.nvim_exec([[
    " Ctags
    function! s:CtagsHandler(job_id, data, event)
        if a:event == 'exit'
            echo "Generating Tags... Complete"
        endif
    endfunction
    function! GenerateCtags()
        let l:ctags_cmd = "ctags -R --fields=+Slk --c-types=+deftuxgsmp -B --exclude=build --exclude=megainclude ."
        echo "Generating Tags..."
        if has('nvim')
            let job = jobstart(l:ctags_cmd, {'on_exit': function('s:CtagsHandler')})
        else
            call system(l:ctags_cmd)
            call s:CtagsHandler(0, "", 'exit')
        endif
    endfunction
    nnoremap <F12> :call GenerateCtags()<CR> 
]], false)

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd('BufLeave', {
  desc = 'Save window view position',
  group = group,
  callback = function()
    vim.api.nvim_exec([[
      if !exists("w:SavedBufView")
          let w:SavedBufView = {}
      endif
      let w:SavedBufView[bufnr("%")] = winsaveview()
    ]], false)
  end,
})

-- TODO: this should be coverted to lua
-- Avoid scrolling when switching buffers
vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Restore window view position',
  group = group,
  callback = function()
    vim.api.nvim_exec([[
      let buf = bufnr("%")
      if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
          let v = winsaveview()
          let atStartOfFile = v.lnum == 1 && v.col == 0
          if atStartOfFile && !&diff
              call winrestview(w:SavedBufView[buf])
          endif
          unlet w:SavedBufView[buf]
      endif
    ]], false)
  end,
})

-- Turn on spell check for specific file types
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Turn on spell check for specific files',
  group = group,
  pattern = { "gitcommit", "markdown", },
  command = [[setlocal spell spelllang=en_us]]
})

-- Use relative line numbers on the focused window if in normal mode.
-- If in insert mode or the window is unfocused, use absolute line numbers.
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.statuscolumn =
      '%s%C%=%{%v:relnum?"%r":"%0"..(float2nr(log10(line("$")))+1).."l"%} '
  end,
  group = numbertogglegroup,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt.statuscolumn =
      '%s%C%=%{%v:relnum?"%l":"%0"..(float2nr(log10(line("$")))+1).."l"%} '
  end,
  group = numbertogglegroup,
})
