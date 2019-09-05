" Exit if fugitive isn't loaded.
if ! filereadable(expand('~/.config/nvim/pack/minpac/start/vim-fugitive/ftdetect/fugitive.vim'))
  finish
endif

" Fugitive mappings.
nnoremap <silent> <M-g>s :Gstatus<CR>
nnoremap <silent> <M-g>d :Gdiff<CR>
nnoremap <silent> <M-g>c :Gcommit<CR>
nnoremap <silent> <M-g>b :Gblame<CR>
nnoremap <silent> <M-g>l :Glog<CR>
nnoremap <silent> <M-g>p :Git push<CR>
nnoremap <silent> <M-g>r :Gread<CR>
nnoremap <silent> <M-g>w :Gwrite<CR>
nnoremap <silent> <M-g>e :Gedit<CR>
nnoremap <silent> <M-g>u :Git up<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2
