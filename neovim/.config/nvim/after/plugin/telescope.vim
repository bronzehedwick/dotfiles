" Exit if Telescope isn't loaded.
if ! exists(':Telescope')
  finish
endif

nnoremap <M-/> <cmd>Telescope find_files<cr>
nnoremap <M-r> <cmd>Telescope live_grep<cr>
nnoremap <M-b> <cmd>Telescope buffers<cr>
nnoremap <M-h> <cmd>Telescope help_tags<cr>
" nnoremap gs <cmd>Telescope grep_string<cr>
" vnoremap gs <cmd>Telescope grep_string<cr>

" vim:fdm=marker ft=vim et sts=2 sw=2

