local map = require'utilities'.map

-- Enable spell checking.
vim.cmd('setlocal spell')

-- Support code fencing syntax highlighting for the listed languages.
vim.g.markdown_fenced_languages = {
  'bash=sh',
  'javascript',
  'js=javascript',
  'json=javascript',
  'typescript',
  'ts=typescript',
  'php',
  'html',
  'css'
}

-- Support YAML and TOML front matter syntax highlighting, via vim-markdown.
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1

-- If an H1 is used as a file heading, don't fold it, via vim-markdown.
vim.g.vim_markdown_folding_style_pythonic = 1

-- Use a dictionary to lookup words.
if vim.fn.executable('dict') then
  vim.opt.keywordprg = 'dict'
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
