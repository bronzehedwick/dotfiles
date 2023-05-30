-- Use the PHP binary to lookup documentation.
vim.opt.keywordprg = 'php --rf'

-- Use phpcs linter.
vim.cmd('compiler phpcs')

-- LSP.
-- See https://github.com/bmewburn/intelephense-docs
local lsp_path = '/opt/homebrew/bin/intelephense'
if vim.fn.filereadable(lsp_path) == 1 then
    vim.lsp.start({
        name = 'intelephense',
        cmd = { 'intelephense', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({'composer.json', 'index.php', '.git'})[1]),
        settings = {
            licenceKey = os.getenv('HOME') .. '/.local/share/intelephense/licence.txt'
        },
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
