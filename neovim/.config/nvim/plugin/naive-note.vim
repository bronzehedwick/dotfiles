" naive-note.vim - Innocent note taking
" Maintainer: Chris DeLuca <https://www.chrisdeluca.me/>
" Version: 0.0.1
" If you asked this plugin what it's most painful life experience was, it'd
" say, '…What?'
" TODO:
" - Un-archive mapping when in archive
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
" - Get dirvish to refresh

if exists('g:loaded_naive_note') || v:version < 700
  finish
endif
let g:loaded_naive_note = 1

if empty(glob('~/Dropbox/Notes/archive'))
  silent execute(':!mkdir -p ~/Dropbox/Notes/archive')
endif

" Open note listing buffer mapping.
nnoremap <leader>o :split ~/Dropbox/Notes<CR>

" Open note archive mapping.
nnoremap <leader>p :split ~/Dropbox/Notes/archive<CR>

" Create a new note mapping.
nnoremap <leader>n :call naivenote#create()<CR>
