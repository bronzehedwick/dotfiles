vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.njk',
    callback = function()
        vim.api.nvim_set_option_value('filetype', 'htmldjango', {scope='local'})
    end
})

-- vim:fdm=marker ft=lua et sts=4 sw=4
