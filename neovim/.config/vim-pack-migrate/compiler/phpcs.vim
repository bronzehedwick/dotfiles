if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'phpcs'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=./vendor/bin/phpcs\ --standard=Drupal\ --extensions=php,module,inc,install,test,profile,theme,css,info,txt\ -q\ --report=emacs
CompilerSet errorformat=%f:%l:%c:%m

" vim:fdm=marker ft=vim et sts=2 sw=2
