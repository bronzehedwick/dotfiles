" Use the PHP binary to lookup documentation.
setlocal keywordprg=php\ --rf

" Use phpcs linter.
execute('compiler phpcs')

" vim:fdm=marker ft=vim et sts=2 sw=2
