" Vim filetype plugin
" Language:	kdl file
" Maintainer:	Ethan Warrick
" Last Change:	2024 Apr 09

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_append")
  finish
endif
let b:did_ftplugin_append = 1

set tabstop=4
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=/*%s*/
