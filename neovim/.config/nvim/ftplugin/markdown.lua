local map = require'utilities'.map

-- Enable spell checking.
vim.cmd('setlocal spell')

-- Support YAML and TOML front matter syntax highlighting, via vim-markdown.
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1

-- If an H1 is used as a file heading, don't fold it, via vim-markdown.
vim.g.vim_markdown_folding_style_pythonic = 1

-- Turn on vim-markdown plugin.
vim.cmd('packadd vim-markdown')

-- Use a dictionary to lookup words.
if vim.fn.executable('dict') then
  vim.opt.keywordprg = 'dict'
  -- nnoremap <buffer> <silent> <S-k> :execute "split " . shellescape(&keywordprg) . "<bar> 0read !" . shellescape(&keywordprg) . " " . expand("<cword>")<bar> :Man!<CR>
end

-- Mapping to toggle todo list status.
function ToggleTodo()
  if (vim.fn.getline('.') == '[x') then
    vim.cmd('normal ^f[lr ')
  else
    vim.cmd('normal ^f[lrx')
  end
end
map {'n', '<LocalLeader>x', '<cmd>lua ToggleTodo()<CR>', silent = true}
