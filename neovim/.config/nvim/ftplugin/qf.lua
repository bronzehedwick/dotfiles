local map = require'utilities'.map

-- Close quickfix list.
map {'n', 'gq', ':cclose<CR>', silent = true}
