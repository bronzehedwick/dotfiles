" FZF buffers are a search, so hide most Vim 'chrome.'
autocmd! FileType fzf
autocmd  FileType fzf set nonumber |
      \ set norelativenumber |
      \ set laststatus=0 |
      \ set noshowmode |
      \ set noruler |
      \| autocmd BufLeave <buffer> set number relativenumber laststatus=2 showmode ruler

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
