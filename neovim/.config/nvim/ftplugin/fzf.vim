" FZF buffers are a search, so hide most Vim 'chrome.'
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode rulersetlocal laststatus=0
" setlocal laststatus=0
" setlocal noshowmode
" setlocal noruler
" setlocal nonumber
" setlocal norelativenumber

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
