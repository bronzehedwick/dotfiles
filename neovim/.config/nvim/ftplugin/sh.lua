-- Start LSP server.
vim.lsp.enable('bashls')

-- Use shellcheck linter.
vim.cmd('compiler shellcheck')
vim.opt_local.makeprg = 'shellcheck -x -f gcc'

-- Use tree sitter.
vim.treesitter.start()
