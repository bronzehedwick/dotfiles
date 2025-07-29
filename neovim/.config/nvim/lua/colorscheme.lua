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

vim.cmd('colorscheme gruvbox')

require('dark_notify').run()

-- vim:fdm=marker ft=lua et sts=4 sw=4
