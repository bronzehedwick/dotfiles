" Turn on spell checking.
setlocal spell

" Change time format for screenplay files.
" 09/07/2019
inoremap <buffer> <C-g><C-t> <C-r>=strftime("%m/%d/%Y")<CR>

" Enable screenplain maker to output PDF versions of scripts.
execute('compiler screenplain')

" vim:fdm=marker ft=vim et sts=2 sw=2
