local map = require'utilities'.map

function GrepOperator(type)
  if (type == 'v') then
    vim.cmd('normal! `<v`>y')
  elseif (type == 'char') then
    vim.cmd('normal! `[v`]y')
  else
    return
  end
  vim.cmd('grep! ' .. vim.fn.shellescape(vim.cmd('@@')))
end

map {'n', 'gs', 'set operatorfunc=GrepOperator<CR>g@'}
map {'v', 'gs', '<c-u>call GrepOperator(visualmode())<CR>'}
