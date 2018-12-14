" Exit if Grepper isn't loaded.
if ! exists(':Grepper')
  finish
endif

" Configure search tools.
let g:grepper = {
      \ 'tools': ['rg', 'rgsass', 'rgtwig', 'rgjs', 'rgphp'],
      \ 'rgsass': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -tsass',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgtwig': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -ttwig',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgjs': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -tjs',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgphp': {
      \   'grepprg': 'rg -H --no-heading --vimgrep --type-add="module:*.module" --type-add="theme:*.theme" -tphp -tmodule -ttheme',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ }}

" Mappings.
nnoremap <M-p> :Grepper<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
