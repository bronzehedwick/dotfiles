-- Detect Drupal .module files.
vim.cmd [[
  augroup drupal
    autocmd BufRead,BufNewFile *.module set filetype=php
  augroup END
]]