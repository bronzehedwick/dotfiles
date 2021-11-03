if exists('g:current_compiler')
  finish
endif
let g:current_compiler = 'stylelint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

if filereadable('node_modules/stylelint/bin/stylelint.js')
  CompilerSet makeprg=node_modules/stylelint/bin/stylelint.js\ --custom-formatter\ ~/.dotfiles/scripts/stylelint-formatter-unix\ %:S
else
  CompilerSet makeprg=stylelint\ --custom-formatter\ ~/.dotfiles/scripts/stylelint-formatter-unix\ %:S
endif
CompilerSet errorformat=%f:%l:%c:%m

" vim:fdm=marker ft=vim et sts=2 sw=2
