" Turn on spell checking.
setlocal spell

" Local mapping to archive a note.
function! ArchiveNote()
  silent execute(':!mv %:p %:h/archive/')
  silent execute(':bdelete')
endfunction
nnoremap <silent><localleader>a :call ArchiveNote()<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
