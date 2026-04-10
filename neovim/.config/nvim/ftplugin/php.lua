-- Start LSP server.
-- The settings only work by putting the licence key in
-- ~/intelephense/licence.txt. Note the UK spelling.
vim.lsp.enable('intelephense')

-- Use tree sitter.
vim.treesitter.start()

-- Use the PHP binary to lookup documentation.
vim.opt.keywordprg = 'php --rf'

-- Use phpcs linter.
vim.cmd('compiler phpcs')

-- Close the last unclosed pair.
vim.keymap.set('i', '<M-l>', require('utilities').close_last_unclosed_pair,
    { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
