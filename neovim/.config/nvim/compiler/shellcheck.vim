if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'shellcheck'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=shellcheck\ -f\ gcc\ --\ %:S
CompilerSet errorformat=%f:%l:%c:\ %m\ [SC%n]

" vim:fdm=marker ft=vim et sts=2 sw=2
