" Vim filetype plugin
" Language:	C
" Maintainer:	Ethan Warrick
" Last Change:	2024 Apr 05

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_append")
  finish
endif
let b:did_ftplugin_append = 1

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
nnoremap <buffer> <F12> <cmd>call GenerateCtags()<CR> 
