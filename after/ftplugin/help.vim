" Vim filetype plugin
" Language:	Vim help file
" Maintainer:	Ethan Warrick
" Last Change:	2024 Apr 05

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_append")
  finish
endif
let b:did_ftplugin_append = 1

nnoremap <buffer> q <cmd>quit<cr>
