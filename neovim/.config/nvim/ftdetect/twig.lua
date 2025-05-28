vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.twig',
    callback = function()
        vim.api.nvim_set_option_value('filetype', 'twig', {scope='local'})
    end
})

-- vim:fdm=marker ft=lua et sts=4 sw=4
