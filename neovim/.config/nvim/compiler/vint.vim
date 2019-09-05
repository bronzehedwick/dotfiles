if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'vint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=vint\ %:S
CompilerSet errorformat=%f:%l:%c:%m

" vim:fdm=marker ft=vim et sts=2 sw=2
