" Git commit mapping to retrieve commit message after failed commit.
function! GetPrevCommit()
  let l:git_toplevel = glob("`git rev-parse --show-toplevel`/.git/COMMIT_EDITMSG")
  :0read `git rev-parse --show-toplevel`/.git/COMMIT_EDITMSG
endfunction
nnoremap <buffer> <silent> <LocalLeader>b :call GetPrevCommit()<CR>
