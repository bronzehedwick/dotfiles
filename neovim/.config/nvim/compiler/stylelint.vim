if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'stylelint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=stylelint\ --custom-formatter\ ~/.dotfiles/scripts/stylelint-formatter-unix\ %:S
CompilerSet errorformat=%f:%l:%c:%m

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
