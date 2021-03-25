" Basic JS from/require include config.
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal suffixesadd=.jsx

" Use eslint linter.
execute('compiler eslint')

" vim:fdm=marker ft=vim et sts=2 sw=2
