-- Start LSP server.
vim.lsp.enable('ts_ls')

-- Basic JS from/require include config.
vim.opt.include = '^\\s*[^/]+(from|require([\'"])'
vim.opt.suffixesadd = '.jsx'

-- Use tree sitter.
vim.treesitter.start()

-- Use eslint linter.
vim.cmd('compiler eslint')

-- vim:fdm=marker ft=lua et sts=4 sw=4
