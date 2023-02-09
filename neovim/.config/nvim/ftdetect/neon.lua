vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group = vim.api.nvim_create_augroup('neon', {}),
  pattern = {'*.neon'},
  callback = function()
    vim.api.nvim_set_option_value('filetype', 'yaml', {scope='local'})
  end
})
