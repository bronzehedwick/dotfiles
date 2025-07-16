vim.o.background = 'light'
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
  vim.o.termguicolors = true
end

require('onedarkpro').setup({
    colors = {
        light = {
            bg = '#FFFFFF',
        },
        dark = {
            bg = '#000000'
        },
    },
    highlights = {
        diffAdded = { fg = { light = '#1da912' } },
        diffChanged = { fg = { light = '#eea825' } },
        diffRemoved = { fg = { light = '#e05661' } },
        DiffAdd = { fg = { light = '#118dc3' } },
        DiffDelete = { fg = { light = '#e05661' } }
    }
})

vim.cmd('colorscheme onelight')

require('dark_notify').run({
    schemes = {
        dark = {
            colorscheme = 'onedark_dark',
            background = 'dark'
        },
        light = {
            colorscheme = 'onelight',
            background = 'light'
        }
    }
})

-- vim:fdm=marker ft=lua et sts=4 sw=4
