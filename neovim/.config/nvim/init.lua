-- Use filetype.lua for performance.
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

require'configurations'
require'mappings'
require'plugins'
require'colorscheme'

-- vim:fdm=marker ft=lua et sts=2 sw=2 path=./lua
