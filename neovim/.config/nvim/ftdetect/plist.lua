-- Detect macOS plist files.
vim.cmd [[
  augroup plist
    autocmd BufRead,BufNewFile *.plist set filetype=xml
  augroup END
]]
