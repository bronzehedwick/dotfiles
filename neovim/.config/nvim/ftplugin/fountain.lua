local map = require'utilities'.map

-- Turn on spell checking.
vim.opt.spell = true

-- Change time format for screenplay files.
-- 09/07/2019
-- inoremap <buffer> <C-g><C-t> <C-r>=strftime("%m/%d/%Y")<CR>
map {'i', '<C-g><C-t>', '<C-r>=strftime("%m/%d/%Y")<CR>'}

-- Enable screenplain maker to output PDF versions of scripts.
vim.fn.execute('compiler screenplain')
