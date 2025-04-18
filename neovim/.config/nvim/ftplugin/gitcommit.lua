-- Turn on spell checking.
vim.opt_local.spell = true

-- Mapping to insert current git ticket into file.
vim.keymap.set('n', '<LocalLeader>t', ':0read !git ticket<CR>', { silent = true })
