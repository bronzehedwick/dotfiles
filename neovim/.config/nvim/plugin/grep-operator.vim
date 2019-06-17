nnoremap gs :set operatorfunc=GrepOperator<CR>g@
vnoremap gs :<c-u>call GrepOperator(visualmode())<CR>

function! GrepOperator(type)
  if a:type ==# 'v'
    execute 'normal! `<v`>y'
  elseif a:type ==# 'char'
    execute 'normal! `[v`]y'
  else
    return
  endif
  silent execute 'grep! ' . shellescape(@@)
endfunction
