-- Start LSP server.
vim.lsp.enable('html')
vim.lsp.enable('emmet-ls')

-- Set pattern for vim to recognize twig includes.
vim.opt_local.include = "^\\s*{%\\s*include|^\\s*{%\\s*embed|^\\s*{%\\s*extends"

-- Use twig commenting instead of HTML.
vim.opt_local.commentstring = "{# %s #}"

-- Use twiglint linter.
vim.cmd('compiler twiglint')

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
