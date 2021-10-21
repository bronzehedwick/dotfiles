-- Basic JS from/require include config.
vim.opt.include = [[^\\s*[^\/]\\+\\(from\\\|require(['"]\\)]]
vim.opt.suffixesadd = '.js'

-- Use eslint linter.
vim.fn.execute('compiler eslint')
