-- Load emmet HTML quickwrite plugin.
vim.cmd('packadd emmet-vim')

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^\\s*{%\\s*include|^\\s*{%\\s*embed|^\\s*{%\\s*extends"

-- Use twig commenting instead of HTML.
vim.opt.commentstring = "{# %s #}"
local ft = require('Comment.ft')
ft.set('htmldjango', '{#%s#}')

-- Use twiglint linter.
vim.cmd('compiler twiglint')

-- LSP.
local lsp_path = '/opt/homebrew/bin/vscode-html-language-server'
if vim.fn.filereadable(lsp_path) == 1 then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.start({
        name = 'html',
        cmd = { 'vscode-html-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({'package.json', '.git'})[1]),
        init_options = {
            provideFormatter = true,
            embeddedLanguages = { css = true, javascript = true },
            configurationSection = { 'html', 'css', 'javascript' },
        },
        capabilities = capabilities,
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
