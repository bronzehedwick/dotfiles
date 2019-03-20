" Location: autoload/naivenote.vim
" Maintainer: Chris DeLuca <https://www.chrisdeluca.me/>

if exists('g:autoloaded_naivenote')
  finish
endif
let g:autoloaded_naivenote = 1

" Create a new note.
function! naivenote#create() abort
  call inputsave()
  let l:note_name = input('Note name: ')
  call inputrestore()
  silent execute(':split ' . expand(g:naivenote#dir) . '/' . join(split(tolower(l:note_name)), '-') . '.md')
  call setline(1, '# ' . l:note_name)
  call setline(2, '')
  silent execute(':write')
endfunction

" Archive a note.
function! naivenote#archive() abort
  silent execute(':!mv ' . shellescape(expand('%:p')) . ' ' . shellescape(expand('%:h') . '/archive/'))
  silent execute(':bdelete')
endfunction

" List notes.
function! naivenote#list() abort
  silent execute(':split ' . expand(g:naivenote#dir))
endfunction