-- Basic JS from/require include config.
vim.opt.include = '^\\s*[^/]+(from|require([\'"])'
vim.opt.suffixesadd = '.jsx'

-- Use eslint linter.
vim.cmd('compiler eslint')
