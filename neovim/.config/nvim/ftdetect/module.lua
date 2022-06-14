-- Detect Drupal .module files.
vim.cmd [[
  augroup drupal
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.theme set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
  augroup END
]]
