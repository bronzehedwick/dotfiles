" Exit if UTL isn't loaded.
if ! exists(':Utl')
  finish
endif

" Configure HTTP handler (works for macOS).
let g:utl_cfg_hdl_scm_http_system = "silent !open '%u'"

" Force UTL to behave. After it sources this everything is fine.
source ~/.config/nvim/pack/minpac/start/utl.vim/plugin/utl_rc.vim

" Quickly open URLs
nnoremap <leader>u :Utl<cr>

" vim:fdm=marker ft=vim et sts=2 sw=2
