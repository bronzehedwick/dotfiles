-- Mappings for built-in Vim git rebase convenience commands.
vim.keymap.set('n', '<LocalLeader>p', ':Pick<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>s', ':Squash<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>e', ':Edit<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>r', ':Reword<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>f', ':Fixup<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>d', ':Drop<CR>', { silent = true })
vim.keymap.set('n', '<LocalLeader>S', ':Cycle<CR>', { silent = true })
