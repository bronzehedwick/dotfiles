npmstart = function()
  if vim.fn.filereadable('package-lock.json') then
    vim.cmd [[
      :edit term://npm\ start
    ]]
  elseif vim.fn.filereadable('yarn.lock') then
    vim.cmd [[
      :edit term://yarn\ start
    ]]
  else
    print('Not a NPM/Yarn repo.')
  end
end

vim.cmd [[
  command NpmStart :lua npmstart()
]]
