-- Add twig pattern files to path to be able to configure below.
-- Enables `gf` on include to jump to that file. Bloom specific.
vim.opt.path = '/Users/chris/Sites/Lullabot/dsga_d8/docroot/themes/custom/ga_bloom/components'

-- Use twig commenting instead of HTML.
vim.opt.commentstring = "{# %s #}"

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^/s*{%/s*include|^/s*{%/s*embed|^/s*{%/s*extends"

-- Use twiglint linter.
vim.cmd('compiler twiglint')

-- Use emmet.
vim.cmd('packadd emmet-vim')

-- Auto complete quotes for HTML attributes.
vim.keymap.set(
  'i',
  '=',
  require('utilities').autocomplete_html_attribute,
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
