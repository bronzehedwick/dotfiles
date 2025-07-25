if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'twigcs'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=~/.composer/vendor/bin/twigcs\ --no-ansi\ --reporter=emacs\ %:S
CompilerSet errorformat=%*[\"]%f%*[\"]\\,%l\\,%m

" vim:fdm=marker ft=vim et sts=2 sw=2
