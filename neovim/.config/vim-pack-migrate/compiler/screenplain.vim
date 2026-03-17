if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'screenplain'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=screenplain\ --format\ pdf\ --strong\ %:S\ %:h/%:t:r.pdf

" vim:fdm=marker ft=vim et sts=2 sw=2
