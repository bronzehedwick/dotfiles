-- Start LSP server.
vim.lsp.enable('jsonls')

-- Use jsonlint if available, otherwise use python's built-in json linter.
if vim.fn.executable('jsonlint') then
    vim.cmd('compiler jsonlint')
else
    vim.cmd('compiler jsontool')
end

-- Use tree sitter.
vim.treesitter.start()

-- Automatically insert a comma at the end of appropriate lines.
-- Inspiration from:
-- https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
vim.keymap.set('n', 'o', function()
    require('utilities').open_line_with_comma({ direction = 'below' })
end, { buffer = true })

vim.keymap.set('n', 'O', function()
    require('utilities').open_line_with_comma({ direction = 'above' })
end, { buffer = true })

vim.keymap.set('n', 'dd', function()
    require('utilities').dd_with_comma_removal()
end, { buffer = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
