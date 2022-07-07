-- Use filetype.lua for performance.
-- Remove these at the next release.
-- See https://github.com/neovim/neovim/issues/14090#issuecomment-1177933661
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

require'configurations'
require'mappings'
require'plugins'
require'colorscheme'

-- vim:fdm=marker ft=lua et sts=2 sw=2 path=./lua
