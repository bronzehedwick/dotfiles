-- Start LSP server.
vim.lsp.enable('cssls')
vim.lsp.enable('css_variables')
vim.lsp.enable('emmet-ls')

-- Use stylelint linter.
vim.fn.execute('compiler stylelint')

-- Use tree sitter.
vim.treesitter.start()

-- vim:fdm=marker ft=lua et sts=4 sw=4
