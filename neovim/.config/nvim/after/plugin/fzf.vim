" Exit if FZF isn't loaded.
if ! exists(':FZF')
    finish
endif

" Fuzzy finder.
nnoremap <M-/> :FZF<CR>
