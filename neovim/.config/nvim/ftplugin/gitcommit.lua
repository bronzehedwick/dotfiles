local map = require'utilities'.map

-- Turn on spell checking.
vim.opt.spell = true

-- Mapping to insert current git ticket into file.
map {'n', '<LocalLeader>t', ':0read !git ticket<CR>', silent = true}
