vim.o.background = 'light'
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
  vim.o.termguicolors = true
end

require('gruvbox').setup({
    contrast = 'hard',
    italic = {
        strings = false,
        comments = false,
        operators = false,
    },
    palette_overrides = {
        light0_hard = '#fff8e3',
    },
})

require('github-theme').setup({
    options = {
        hide_end_of_buffer = false,
        hide_nc_statusline = false
    }
})

vim.cmd('colorscheme github_light')

require('dark_notify').run({
    schemes = {
        dark = {
            colorscheme = 'github_dark',
            background = 'dark'
        },
        light = {
            colorscheme = 'github_light',
            background = 'light'
        }
    }
})

-- vim:fdm=marker ft=lua et sts=4 sw=4
