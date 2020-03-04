if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'phpcs'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=~/.composer/vendor/squizlabs/php_codesniffer/bin/phpcs\ --standard=Drupal\ -q\ --report=emacs\ %:S
CompilerSet errorformat=%f:%l:%c:%m

" vim:fdm=marker ft=vim et sts=2 sw=2
