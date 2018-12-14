" Exit if Pad isn't loaded.
if ! exists(':Pad')
  finish
endif

" Notes configuration.
let g:pad#dir = '~/Dropbox/Notes'
let g:pad#default_file_extension = '.md'
let g:pad#window_height = 12
let g:pad#set_mappings = 0

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
