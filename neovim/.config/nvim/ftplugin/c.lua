-- Use treesitter.
vim.treesitter.start()

-- Use gcc/cc compiler.
vim.fn.execute('compiler clang')

-- 4 spaces is a common standard in C.
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
