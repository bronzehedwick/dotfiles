" primary-terminal.vim - Simple terminal management
" Maintainer: Chris DeLuca <https://www.chrisdeluca.me/>
" Version: 0.0.1
" TODO:
" - Document functions
" - Create help
" - Pull out into a new repo
" - Add split/tab/etc functions to open the terminal
" - Provide consistent interface for mappings to grab onto
" - Use this as a checklist: http://stevelosh.com/blog/2011/09/writing-vim-plugins
" - Check platform support
" - Vim8 support

if exists('g:loaded_primaryterminal') || &cp || v:version < 700 " {{{
  finish
endif
let g:loaded_primaryterminal = 1 " }}}

function! SetupTerminal() " {{{
  if !exists('g:primary_terminal_job_id')
    let g:primary_terminal_job_id = b:terminal_job_id
    let g:primary_terminal_buffer_file = expand('%:p')
    let g:primary_terminal_buffer_id = bufnr('%')
  endif
endfunction " }}}

function! TeardownTerminal() " {{{
  if bufnr('%') == g:primary_terminal_buffer_id
    unlet! g:primary_terminal_job_id g:primary_terminal_buffer_id g:primary_terminal_buffer_file
  endif
endfunction " }}}

function! TermCommand(bang, command) " {{{
  if a:bang
    :execute 'pedit ' . g:primary_terminal_buffer_file
  endif
  call jobsend(g:primary_terminal_job_id, a:command . "\<CR>")
endfunction
command! -nargs=1 -bang T call TermCommand(<bang>0, <q-args>) " }}}

function! TermOpen() " {{{
  if exists('g:primary_terminal_buffer_id')
    :execute 'buffer' . g:primary_terminal_buffer_id
  else
    :terminal
  endif
endfunction " }}}

augroup terminal " {{{
  autocmd!
  " Setup primary terminal.
  autocmd TermOpen * call SetupTerminal()
  " Remove primary terminal if it's closed.
  autocmd TermClose * call TeardownTerminal()
augroup END " }}}

" vim: fdm=marker: sw=2
