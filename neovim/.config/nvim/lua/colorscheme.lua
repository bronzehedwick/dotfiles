vim.o.background = 'light'
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
  vim.o.termguicolors = true
end

vim.g.xcodelight_green_comments = 1
vim.g.xcodedarkhc_green_comments = 1
vim.g.xcodelight_match_paren_style = 1
vim.g.xcodedarkhc_match_paren_style = 0

vim.cmd.colorscheme 'xcodelight'

require('dark_notify').run({
    schemes = {
        light = 'xcodelight',
        dark = 'xcodedarkhc'
    }
})

-- -- vim:fdm=marker ft=lua et sts=4 sw=4
