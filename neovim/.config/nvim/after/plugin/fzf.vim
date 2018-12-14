" Exit if FZF isn't loaded.
if ! exists(':FZF')
  finish
endif

" Fuzzy finder.
nnoremap <M-/> :FZF<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
