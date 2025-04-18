-- Use treesitter.
vim.treesitter.start()

-- Turn off spell checking; I don't care about spelling errors I can't correct.
vim.opt_local.spell = false

-- Turn off visible tab characters, since the files are read only.
vim.opt_local.list = false
