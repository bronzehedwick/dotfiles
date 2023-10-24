-- Close quickfix list.
vim.keymap.set('n', 'gq', ':cclose<CR>', { buffer = true, silent = true })
-- vim.keymap.set('n', 'gq', function()
--     local wininfo = vim.fn.getwininfo()
-- end, { buffer = true, silent = true })

-- No numbers in the quickfix list.
vim.opt_local.number = false;
vim.opt_local.relativenumber = false;
