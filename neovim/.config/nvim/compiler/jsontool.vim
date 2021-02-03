if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'jsontool'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

" Expecting property name enclosed in double quotes: line 382 column 15 (char 13948)

CompilerSet makeprg=python3\ -m\ json.tool\ %:S
CompilerSet errorformat=%m:%l%c

" vim:fdm=marker ft=vim et sts=2 sw=2
