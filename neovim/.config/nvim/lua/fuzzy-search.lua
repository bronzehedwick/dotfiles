local M = {}

M.FuzzySearch = function()
  local width = 55
  local height = 11

  vim.api.nvim_open_win(
    vim.api.nvim_create_buf(false, true),
    true,
    {
      relative = 'editor',
      style = 'minimal',
      border = 'shadow',
      width = width,
      height = height,
      col = math.min((vim.o.columns - width) * 0.5),
      row = math.min((vim.o.lines - height) * 0.5 - 1),
      noautocmd = true,
    }
  )

  vim.fn.termopen('git ls-files|fzy --lines ' .. (height - 1) .. '|xargs nvr --nostart --remote -cc "lua vim.api.nvim_win_close(vim.fn.win_getid(), true)" -l')
  vim.api.nvim_command('startinsert')
end

return M
