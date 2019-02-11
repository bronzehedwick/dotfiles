if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'yamllint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=yamllint\ --format\ parsable\ --\ %:S
CompilerSet errorformat=%E%f:%l:%c:\ \[error\]\ %m,%W%f:%l:%c:\ \[warning\]\ %m

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
