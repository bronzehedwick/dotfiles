-- Start LSP server.
vim.lsp.enable('cssls')
vim.lsp.enable('css_variables')
vim.lsp.enable('emmet-ls')

-- Use stylelint linter.
vim.fn.execute('compiler stylelint')

-- Use tree sitter.
vim.treesitter.start()

-- Close the last unclosed pair.
vim.keymap.set('i', '<M-l>', require('utilities').close_last_unclosed_pair,
    { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
