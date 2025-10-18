-- Add twig pattern files to path to be able to configure below.

-- Use twig commenting instead of HTML.
vim.opt_local.commentstring = '{# %s #}'

-- Set pattern for vim to recognize twig includes.
vim.opt_local.include = '^/s*{%/s*include|^/s*{%/s*embed|^/s*{%/s*extends'

-- Use manual fold method, since Treesitter doesn't have one for Twig.
vim.opt_local.foldmethod = 'manual'

-- Use twiglint linter.
vim.cmd('compiler twigcs')

-- Use emmet.
vim.cmd('packadd emmet-vim')

-- Auto complete quotes for HTML attributes.
vim.keymap.set(
    'i',
    '=',
    function()
        return require('utilities').autocomplete_html_attribute({'attribute_name'})
    end,
    { expr = true, buffer = true }
)

-- LSP.
local lsp_path = '/opt/homebrew/bin/vscode-html-language-server'
if vim.fn.filereadable(lsp_path) == 1 then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.start({
        name = 'html',
        cmd = { 'vscode-html-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({'package.json', '.git'}, {})[1]),
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
            configurationSection = { 'html', 'css', 'javascript' },
        },
        capabilities = capabilities,
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
