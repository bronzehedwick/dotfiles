if exists('current_compiler')
  finish
endif
let current_compiler = 'jsonlint'

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=jsonlint\ --compact\ %

CompilerSet errorformat=%ELine\ %l:%c,
      \%Z\\s%#Reason:\ %m,
      \%C%.%#,
      \%f:\ line\ %l\\,\ col\ %c\\,\ %m,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
