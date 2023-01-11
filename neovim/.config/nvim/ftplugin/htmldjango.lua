-- Load emmet HTML quickwrite plugin.
vim.cmd('packadd emmet-vim')

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^\\s*{%\\s*include|^\\s*{%\\s*embed|^\\s*{%\\s*extends"

-- Use twig commenting instead of HTML.
vim.opt.commentstring = "{# %s #}"
local ft = require('Comment.ft')
ft.set('htmldjango', '{#%s#}')

-- Use twiglint linter.
vim.cmd('compiler twiglint')
