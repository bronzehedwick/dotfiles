" Turn on spell checking.
setlocal spell

" Mapping to insert current git ticket into file.
nnoremap <buffer> <silent> <LocalLeader>t :0read !git ticket<cr>

" Save contents of a buffer to register g.
function! s:SaveBuffer() abort
  silent normal! gg
  silent normal! "gyG
endfunction
autocmd BufWritePre <buffer> call s:SaveBuffer()

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
