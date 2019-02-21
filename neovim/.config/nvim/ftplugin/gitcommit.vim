" Turn on spell checking.
setlocal spell

" Mapping to insert current git ticket into file.
nnoremap <buffer> <silent> <LocalLeader>t :0read !git ticket<cr>

" Mapping to retrieve commit message after failed commit.
function! GetPrevCommit()
  let l:git_toplevel = glob("`git rev-parse --show-toplevel`/.git/COMMIT_EDITMSG")
  :0read `git rev-parse --show-toplevel`/.git/COMMIT_EDITMSG
endfunction
nnoremap <buffer> <silent> <LocalLeader>b :call GetPrevCommit()<CR>

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
