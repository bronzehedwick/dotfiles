local map = require'utilities'.map

-- Enable spell checking.
vim.cmd('setlocal spell')

-- Default to 4 space indent, as that's the amount that triggers preformatted
-- text in markdown.
vim.opt.shiftwidth = 4

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
  'lua',
  'css'
}

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
