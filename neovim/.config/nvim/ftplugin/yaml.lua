-- Start LSP server.
vim.lsp.enable('yamlls')

-- Use tree sitter.
vim.treesitter.start()

-- Use yamllint linter.
vim.cmd('compiler yamllint')
