command NpmStart :call NpmStartFunc()

function! NpmStartFunc()
  if filereadable('package-lock.json')
    :edit term://npm\ start
  elseif filereadable('yarn.lock')
    :edit term://yarn\ start
  else
    echo 'Not a NPM/Yarn repo'
  endif
endfunction
