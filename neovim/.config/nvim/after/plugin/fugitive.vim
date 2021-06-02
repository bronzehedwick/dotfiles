" Exit if fugitive isn't loaded.
if ! filereadable(expand('~/.local/share/nvim/site/pack/packer/start/vim-fugitive/ftdetect/fugitive.vim'))
  finish
endif

" Status line.
" Git branch.
set statusline=%{FugitiveStatusline()}
" Tail of file (just the name.ext).
set statusline+=%<\ %t
" File modified flag.
set statusline+=%m
" Buffer is `help` flag.
set statusline+=%<\ %h
" Buffer is `readonly` flag.
set statusline+=%<\ %r
" Buffer is `preview` flag.
set statusline+=%<\ %w
" New group.
set statusline+=%=
" Line and column number.
set statusline+=%l
" New group.
set statusline+=%=
" Percentage through the file.
set statusline+=%p%%

" Add back async fugitive mappings.
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git fetch' <q-args>
command! -bang -bar -nargs=* Gup execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git up' <q-args>
command! -bang -bar -nargs=* Gpo execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git po' <q-args>

" Fugitive mappings.
nnoremap <silent> <M-g>s :Git<CR>
nnoremap <silent> <M-g>d :Gdiff<CR>
nnoremap <silent> <M-g>c :Git commit<CR>
nnoremap <silent> <M-g>b :Git blame<CR>
nnoremap <silent> <M-g>l :Gclog<CR>
nnoremap <silent> <M-g>p :Gpo<CR>
nnoremap <silent> <M-g>r :Gread<CR>
nnoremap <silent> <M-g>w :Gwrite<CR>
nnoremap <silent> <M-g>e :Gedit<CR>
nnoremap <silent> <M-g>u :Gup<CR>
nnoremap <silent> <M-g>f :Gfetch<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2
