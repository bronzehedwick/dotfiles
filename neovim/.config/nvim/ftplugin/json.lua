-- Use jsonlint if available, otherwise use python's built-in json linter.
if vim.fn.executable('jsonlint') then
  vim.cmd('compiler jsonlint')
else
  vim.cmd('compiler jsontool')
end

-- Automatically insert a comma at the end of appropriate lines.
-- @see https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
vim.keymap.set('n', 'o', function()
  local line = vim.api.nvim_get_current_line()
  local should_add_comma = string.find(line, '[^,{[]$')
  if should_add_comma then
    return 'A,<cr>'
  else
    return 'o'
  end
end, { buffer = true, expr = true })
