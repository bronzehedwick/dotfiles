-- Use jsonlint if available, otherwise use python's built-in json linter.
if vim.fn.executable('jsonlint') then
    vim.cmd('compiler jsonlint')
else
    vim.cmd('compiler jsontool')
end

-- Automatically insert a comma at the end of appropriate lines.
-- Inspiration from:
-- https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
vim.keymap.set('n', 'o', function()
    local line = vim.api.nvim_get_current_line()
    local should_add_comma = string.find(line, '[^,{[]$')
    if should_add_comma then
        return 'A,<cr>'
    else
        return 'o'
    end
end, { buffer = true, expr = true })

vim.keymap.set('n', 'O', function()
    local line_num = vim.fn.line('.') - 1
    local line_above = vim.fn.getline(line_num)
    local should_add_comma = string.find(line_above, '[^,{[]$')
    if should_add_comma then
        return '<Up>A,<cr>'
    else
        return 'O'
    end
end, { buffer = true, expr = true })

vim.keymap.set('n', 'dd', function()
    local line = vim.api.nvim_get_current_line()
    local should_remove_comma = string.find(line, '[^,{[]$')
    if should_remove_comma then
        return 'dd<Up>$x'
    else
        return 'dd'
    end
end, { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
