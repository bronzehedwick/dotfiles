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

-- vim:fdm=marker ft=lua et sts=4 sw=4
