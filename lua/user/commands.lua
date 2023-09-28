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
