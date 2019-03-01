" naive-note.vim - Innocent note taking
" Maintainer: Chris DeLuca <https://www.chrisdeluca.me/>
" Version: 0.0.1
" If you asked this plugin what it's most painful life experience was, it'd
" say, '…What?'
" TODO:
" - Un-archive mapping when in archive
" - Change interface? Instead of input, command line
" - Export as plugin(?)
"   - Configurable split calls
"   - Figure out minimum vim version needed
"   - Write documentation
"   - Write readme
"   - Type of file generated configurable(?)
"   - Use <Plug> interface(?)
" - Get dirvish to refresh

if exists('g:loaded_naivenote') || &cp || v:version < 700
  finish
endif
let g:loaded_naivenote = 1

if !exists('g:naivenote#dir')
  echom 'naivenote: please set g:naivenote#dir in your configuration.'
  finish
endif

if empty(glob(expand(g:naivenote#dir) . '/archive'))
  silent execute(':!mkdir -p ' . expand(g:naivenote#dir) . '/archive')
endif
