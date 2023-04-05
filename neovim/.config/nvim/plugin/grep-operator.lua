vim.cmd[[
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

  nnoremap gs <Esc>:set operatorfunc=GrepOperator<cr>g@
  vnoremap gs <Esc><c-u>call GrepOperator(visualmode())<cr>
]]
