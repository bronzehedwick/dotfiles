-- Start LSP server.
vim.lsp.enable('html')
vim.lsp.enable('emmet-ls')

-- Use tree sitter.
vim.treesitter.start()

-- Auto complete quotes for HTML attributes.
vim.keymap.set(
    'i',
    '=',
    function()
      return require('utilities').autocomplete_html_attribute({'attribute_name'})
    end,
    { expr = true, buffer = true }
)

-- Close the last unclosed pair.
vim.keymap.set('i', '<M-l>', require('utilities').close_last_unclosed_pair,
    { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
