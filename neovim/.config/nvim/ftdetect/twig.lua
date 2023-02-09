vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.twig',
  callback = function()
    vim.api.nvim_set_option_value('filetype', 'htmldjango', {scope='local'})
  end
})
