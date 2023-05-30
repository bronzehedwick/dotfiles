-- Basic JS from/require include config.
vim.opt.include = [[^\\s*[^\/]\\+\\(from\\\|require(['"]\\)]]
vim.opt.suffixesadd = '.js'

-- Use eslint linter.
vim.fn.execute('compiler eslint')

-- LSP.
local lsp_path = '/opt/homebrew/bin/tsserver'
if vim.fn.filereadable(lsp_path) == 1 then
    vim.lsp.start({
        name = 'typescript',
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({'package.json', 'jsconfig.json', '.git'})[1]),
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
