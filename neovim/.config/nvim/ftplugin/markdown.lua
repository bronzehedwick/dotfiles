local map = require'utilities'.map

-- Enable spell checking.
vim.cmd('setlocal spell')

-- Default to 4 space indent, as that's the amount that triggers preformatted
-- text in markdown.
vim.bo.shiftwidth = 4

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
  vim.bo.keywordprg = 'dict'
end

-- Mapping to toggle todo list status.
function ToggleTodo()
  vim.cmd('normal mp')
  if (string.match(vim.fn.getline('.'), '[x]')) then
    vim.cmd('normal ^f[lr ')
  else
    vim.cmd('normal ^f[lrx')
  end
  vim.cmd('normal `p')
end
map {'n', '<LocalLeader>x', '<cmd>lua ToggleTodo()<CR>', silent = true}
