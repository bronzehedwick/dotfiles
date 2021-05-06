" Exit if picker isn't loaded.
if ! exists(':UndotreeToggle')
  finish
endif

" Add mapping for undotree.
nnoremap <F8> :UndotreeToggle<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2
