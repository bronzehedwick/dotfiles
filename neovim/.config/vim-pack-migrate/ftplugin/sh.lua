-- Use shellcheck linter.
vim.cmd('compiler shellcheck')
vim.opt_local.makeprg = 'shellcheck -x -f gcc'
