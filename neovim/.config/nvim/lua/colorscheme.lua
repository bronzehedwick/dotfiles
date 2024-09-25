vim.o.background = 'light'
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
  vim.o.termguicolors = true
end

-- xcode color theme.
vim.g.xcode_green_comments = 1
vim.g.xcode_match_paren_style = 1

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

-- vim.cmd('colorscheme xcode')
vim.cmd('colorscheme gruvbox')

require('dark_notify').run()

-- vim:fdm=marker ft=lua et sts=4 sw=4
