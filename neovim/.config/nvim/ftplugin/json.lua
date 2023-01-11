-- Use jsonlint if available, otherwise use python's built-in json linter.
if vim.fn.executable('jsonlint') then
  vim.cmd('compiler jsonlint')
else
  vim.cmd('compiler jsontool')
end
