-- Use stylelint linter.
vim.fn.execute('compiler stylelint')

-- LSP.
local lsp_path = '/opt/homebrew/bin/cssls'
if vim.fn.filereadable(lsp_path) == 1 then
    vim.lsp.start({
        name = 'cssls',
        cmd = { 'vscode-css-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fsg.find({'package.json', '.git'})[1]),
        single_file_support = true,
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
