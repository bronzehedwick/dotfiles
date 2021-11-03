function FuzzySearch()
  local width = 30
  local height = 15

  local popup = vim.api.nvim_open_win(
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

  local f = assert(io.popen('git rev-parse --abbrev-ref HEAD', 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', '')

  vim.fn.termopen('git ls-tree -r --name-only ' .. s .. '|fzy')
  vim.api.nvim_command('startinsert')

end

return FuzzySearch
