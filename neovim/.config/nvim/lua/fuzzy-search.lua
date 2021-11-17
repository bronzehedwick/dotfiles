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

  local raw_git_branch = assert(io.popen('git rev-parse --abbrev-ref HEAD', 'r'))
  local git_branch = assert(raw_git_branch:read('*a'))
  raw_git_branch:close()
  git_branch = string.gsub(git_branch, '^%s+', '')
  git_branch = string.gsub(git_branch, '%s+$', '')
  git_branch = string.gsub(git_branch, '[\n\r]+', '')

  vim.fn.termopen('git ls-tree -r --name-only ' .. git_branch .. '|fzy --lines ' .. (height - 1) .. '|xargs nvr --nostart --remote -cc "lua vim.api.nvim_win_close(vim.fn.win_getid(), true)" -l')
  vim.api.nvim_command('startinsert')
end

return M
