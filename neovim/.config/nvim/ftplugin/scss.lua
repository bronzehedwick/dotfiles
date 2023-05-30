-- Use stylelint linter.
vim.fn.execute('compiler stylelint')

-- LSP.
local lsp_path = '/opt/homebrew/bin/vscode-css-language-server'
if vim.fn.filereadable(lsp_path) == 1 then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.lsp.start({
        name = 'cssls',
        cmd = { 'vscode-css-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({'package.json', '.git'})[1]),
        single_file_support = true,
        capabilities = capabilities,
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
