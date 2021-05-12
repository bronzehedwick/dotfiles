command NpmStart :call NpmStartFunc()
command NpmStop :call NpmStopFunc()

function! NpmStartFunc()
  if filereadable('package-lock.json')
    :edit term://npm\ start
  elseif filereadable('yarn.lock')
    :edit term://yarn\ start
  else
    echo 'Not a NPM/Yarn repo'
  endif
  if !exists('g:npm_commands_buffer_id')
    let g:npm_commands_buffer_id = bufnr('%')
  endif
endfunction

function! NpmStopFunc()
  if exists('g:npm_commands_buffer_id')
    :execute 'bdelete!' . g:npm_commands_buffer_id
    unlet! g:npm_commands_buffer_id
  endif
endfunction
