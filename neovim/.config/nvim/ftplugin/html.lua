-- Load emmet HTML quickwrite plugin.
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
