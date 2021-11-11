-- Use the PHP binary to lookup documentation.
vim.opt.keywordprg = 'php --rf'

-- Use phpcs linter.
vim.cmd('compiler phpcs')
