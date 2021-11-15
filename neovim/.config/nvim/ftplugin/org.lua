local map = require'utilities'.map

-- Enable spell checking.
vim.cmd('setlocal spell')

-- Use a dictionary to lookup words.
if vim.fn.executable('dict') then
  vim.opt.keywordprg = 'dict'
  -- nnoremap <buffer> <silent> <S-k> :execute "split " . shellescape(&keywordprg) . "<bar> 0read !" . shellescape(&keywordprg) . " " . expand("<cword>")<bar> :Man!<CR>
end

-- Insert time in this format: [2021-09-01 Wed]
map {'i', '<C-g><C-t>', '<C-r>=strftime("[%Y-%m-%d %a]")<CR>'}
