-- Start LSP server.
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')

-- Basic JS from/require include config.
vim.opt_local.include = [[^\\s*[^\/]\\+\\(from\\\|require(['"]\\)]]
vim.opt_local.suffixesadd = '.js'

-- Use tree sitter.
vim.treesitter.start()

-- Spell check should only be enabled for comments with treesitter; it isn't.
vim.opt_local.spell = false

-- Use eslint linter.
vim.fn.execute('compiler eslint')

-- Format with prettier (range-aware).
vim.opt_local.formatexpr = "v:lua.require'utilities'.prettier_formatexpr()"

vim.keymap.set('n', 'o', function()
    require('utilities').open_line_with_comma({ direction = 'below' })
end, { buffer = true })

vim.keymap.set('n', 'O', function()
    require('utilities').open_line_with_comma({ direction = 'above' })
end, { buffer = true })

vim.keymap.set('n', 'dd', function()
    require('utilities').dd_with_comma_removal()
end, { buffer = true })

-- Close the last unclosed pair.
vim.keymap.set('i', '<M-l>', require('utilities').close_last_unclosed_pair,
    { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
