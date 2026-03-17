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

" Taken from:
" https://begriffs.com/posts/2019-07-19-history-use-vim.html?hn=3#edit-compile-cycle
"
" formatting variations documented at
" https://clang.llvm.org/docs/UsersManual.html#formatting-of-diagnostics
"
" It should be possible to make this work for the combination of
" -fno-show-column and -fcaret-diagnostics as well with multiline
" and %p, but I was too lazy to figure it out.
"
" The %D and %X patterns are not clang per se. They capture the
" directory change messages from (GNU) 'make -w'. I needed this
" for building a project which used recursive Makefiles.

CompilerSet errorformat=
        \%f:%l%c:{%*[^}]}{%*[^}]}:\ %trror:\ %m,
        \%f:%l%c:{%*[^}]}{%*[^}]}:\ %tarning:\ %m,
        \%f:%l:%c:\ %trror:\ %m,
        \%f:%l:%c:\ %tarning:\ %m,
        \%f(%l,%c)\ :\ %trror:\ %m,
        \%f(%l,%c)\ :\ %tarning:\ %m,
        \%f\ +%l%c:\ %trror:\ %m,
        \%f\ +%l%c:\ %tarning:\ %m,
        \%f:%l:\ %trror:\ %m,
        \%f:%l:\ %tarning:\ %m,
        \%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
        \%D%*\\a:\ Entering\ directory\ %*[`']%f',
        \%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
        \%X%*\\a:\ Leaving\ directory\ %*[`']%f',
        \%DMaking\ %*\\a\ in\ %f

" vim:fdm=marker ft=vim et sts=2 sw=2
