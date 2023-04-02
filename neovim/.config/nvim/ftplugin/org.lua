-- Enable spell checking.
vim.opt_local.spell = true

-- Set conceal
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = 'nc'

-- Use a dictionary to lookup words.
if vim.fn.executable('dict') then
    vim.opt.keywordprg = 'dict'
end

-- Insert time in this format: [2021-09-01 Wed]
vim.keymap.set('i', '<C-g><C-t>', '<C-r>=strftime("[%Y-%m-%d %a]")<CR>')

-- vim:fdm=marker ft=lua et sts=2 sw=2
