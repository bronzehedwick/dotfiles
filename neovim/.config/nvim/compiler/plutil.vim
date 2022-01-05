if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'plutil'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=plutil\ -lint\ %:S
CompilerSet errorformat=%f:%m\ at\ line\ %l

" vim:fdm=marker ft=vim et sts=2 sw=2
