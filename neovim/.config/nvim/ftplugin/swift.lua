local util = require 'utilities'

-- The Swift Treesitter implementation doesn't do smart spelling as far as I can tell.
vim.opt_local.spell = false

-- LSP.
local lsp_path = '~/.local/share/nvim/sourcekit-lsp'
if vim.fn.filereadable(lsp_path) == 1 then
    vim.lsp.start({
        name = 'sourcekit-lsp',
        init_options = { hostInfo = 'neovim' },
        cmd = { 'sourcekit-lsp' },
        setup = {},
        root_dir = function(filename, _)
            return util.root_pattern 'buildServer.json'(filename)
                or util.root_pattern('*.xcodeproj', '*xcworkspace')(filename)
                or util.root_pattern('compile_commands.json', 'Package.swift')(filename)
                or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
        end,
    })
end

-- vim:fdm=marker ft=lua et sts=4 sw=4
