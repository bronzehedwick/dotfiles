" naive-note.vim - Innocent note taking
" Maintainer: Chris DeLuca <https://www.chrisdeluca.me/>
" Version: 0.0.1
" If you asked this plugin what it's most painful life experience was, it'd
" say, '…What?'
" TODO:
" - Get dirvish to refresh
" - Consistent interface (NaiveNote new, NaiveNote list, etc)
" - Export as plugin(?)
"   - Note directory configurable
"   - Error when note directory variable isn't present
"   - All mappings configurable
"   - Configurable split calls
"   - Figure out minimum vim version needed
"   - Figure out what `&cp` is, and if needed
"   - Write documentation
"   - Write readme
"   - Type of file generated configurable(?)

if exists('g:loaded_naive_note') || v:version < 700
  finish
endif
let g:loaded_naive_note = 1

" Open note listing buffer.
nnoremap <leader>o :split ~/Dropbox/Notes<CR>

" Open note archive.
nnoremap <leader>p :split ~/Dropbox/Notes/archive<CR>

" Create a new note.
function! CreateNote()
  call inputsave()
  let l:note_name = input('Note name: ')
  call inputrestore()
  execute ':split ~/Dropbox/Notes/' . join(split(tolower(l:note_name)), '-') . '.md'
  call setline(1, '# ' . l:note_name)
  call setline(2, '')
  execute ':write'
endfunction
nnoremap <leader>n :call CreateNote()<CR>
