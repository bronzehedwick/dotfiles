" Turn on spell checking.
setlocal spell

nnoremap <silent><localleader>a :call naivenote#archive()<CR>

" Insert time into a document.
inoremap <C-g><C-t> <C-r>=strftime("## %b %d %Y, %H:%M:%S")<cr>

" vim:fdm=marker ft=vim et sts=2 sw=2
