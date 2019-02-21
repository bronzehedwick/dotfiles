" Keep Vim indent at 2 spaces despite other configuration.
" The only thing that would override this is editorconfig.
setlocal shiftwidth=2
setlocal tabstop=2

" Use vint linter.
execute('compiler vint')

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
