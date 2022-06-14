-- Setup LSP completion.
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Use single line comments for auto commenting.
vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
