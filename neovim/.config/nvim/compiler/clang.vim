if exists('g:current_compiler')
  finish
endif

if filereadable('Makefile')
  finish
endif

let g:current_compiler = 'clang'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

if filereadable('/usr/bin/clang')
  CompilerSet makeprg=cc\ %:S\ -o\ %:r
endif

" TODO: Create better error format.
" Currently Vim does not consume multi-lines error messages.
" CompilerSet errorformat=%A%f:%l:%c:%m,%-G%.%#

" vim:fdm=marker ft=vim et sts=2 sw=2

