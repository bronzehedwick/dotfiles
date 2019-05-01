if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'eslint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

if filereadable('node_modules/eslint/bin/eslint.js')
  CompilerSet makeprg=node_modules/eslint/bin/eslint.js\ --format=unix\ %:S
else
  CompilerSet makeprg=eslint\ --format=unix\ %:S
endif
CompilerSet errorformat=%A%f:%l:%c:%m,%-G%.%#

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
