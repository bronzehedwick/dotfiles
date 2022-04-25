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

vim.keymap.set('n', 'gs', 'set operatorfunc=GrepOperator<CR>g@')
vim.keymap.set('v', 'gs', '<c-u>call GrepOperator(visualmode())<CR>')
