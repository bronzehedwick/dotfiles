-- Start LSP server.
vim.lsp.enable('html')
vim.lsp.enable('emmet-ls')

-- Add twig pattern files to path to be able to configure below.

-- Use tree sitter.
vim.treesitter.start()

-- Use twig commenting instead of HTML.
vim.opt_local.commentstring = '{# %s #}'

-- Set pattern for vim to recognize twig includes.
vim.opt_local.include = '^/s*{%/s*include|^/s*{%/s*embed|^/s*{%/s*extends'

-- Use manual fold method, since Treesitter doesn't have one for Twig.
vim.opt_local.foldmethod = 'manual'

-- Use twiglint linter.
vim.cmd('compiler twigcs')

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
