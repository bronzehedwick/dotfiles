vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    group = vim.api.nvim_create_augroup('log', {}),
    pattern = {'*.log'},
    callback = function()
        vim.api.nvim_set_option_value('filetype', 'log', {scope='local'})
    end
})

-- vim:fdm=marker ft=lua et sts=4 sw=4
