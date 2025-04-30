-- Turn on spell checking.
vim.opt_local.spell = true

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 2

-- Mapping to insert current git ticket into file.
vim.keymap.set('n', '<LocalLeader>t', ':0read !git ticket<CR>', { silent = true })
