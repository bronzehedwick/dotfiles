-- Always use htmldjango for all html files.
vim.cmd [[
  augroup htmldjango
    autocmd BufNewFile,BufRead *.html set filetype=htmldjango
  augroup END
]]
