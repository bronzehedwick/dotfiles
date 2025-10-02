-- Close quickfix list.
vim.keymap.set('n', 'gq', ':bdelete<CR>', { buffer = true, silent = true })

-- No numbers in the quickfix list.
vim.opt_local.number = false
vim.opt_local.relativenumber = false

-- No spelling in the quickfix list. Come on.
vim.opt_local.spell = false
