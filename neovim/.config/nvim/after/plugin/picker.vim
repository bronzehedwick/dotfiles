" Exit if fugitive isn't loaded.
if ! exists(':PickerEdit')
  finish
endif

" Add custom picker split commands.
command! -bar PickerBufferSplit split | PickerBuffer
command! -bar PickerBufferVsplit vsplit | PickerBuffer

" Add vim picker mappings.
nmap <unique> <M-,> <Plug>(PickerTabedit)
nmap <unique> <M-.> <Plug>(PickerSplit)
nmap <unique> <M-/> <Plug>(PickerEdit)
nmap <unique> <M-;> <Plug>(PickerVsplit)
nmap <unique> <M-[> <Plug>(PickerStag)
nmap <unique> <M-]> <Plug>(PickerTag)
nmap <unique> <M-h> <Plug>(PickerHelp)
nmap <unique> <M-}> <Plug>(PickerBufferTag)
nmap <unique> <leader>l <Plug>(PickerBuffer)
nmap <unique> <leader>. :PickerBufferSplit<CR>
nmap <unique> <leader>; :PickerBufferVsplit<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
