vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = vim.api.nvim_create_augroup('fountain', {}),
  pattern = '*.fountain',
  callback = function()
    vim.api.nvim_set_option_value('filetype', 'fountain', {scope='local'})
  end
})
