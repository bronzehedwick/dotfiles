-- Auto commands {{{

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
        if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
        vim.cmd('TSUpdate')
    end
end })

vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'LuaSnip' and kind == 'update' then
        vim.cmd('!zsh -c \'make -C "$HOME/.local/share/${NVIM_APPNAME:-nvim}/site/pack/core/opt/LuaSnip" install_jsregexp\'')
    end
end })

-- }}}

vim.pack.add({

    -- Utilities {{{
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    {
        src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        version = 'main'
    },
    'https://github.com/RRethy/nvim-treesitter-endwise',
    'https://github.com/tpope/vim-dispatch',
    'https://github.com/justinmk/vim-ipmotion',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mfussenegger/nvim-dap',
    -- }}}

    -- Movement {{{
    'https://github.com/tpope/vim-rsi',
    'https://github.com/tpope/vim-unimpaired',
    'https://github.com/leath-dub/snipe.nvim',
    {
        src = 'https://git.disroot.org/andyg/leap.nvim.git',
        version = 'main'
    },
    -- }}}

    -- Git {{{
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tommcdo/vim-fubitive',
    'https://github.com/tpope/vim-rhubarb',
    'https://github.com/lewis6991/gitsigns.nvim',
    -- }}}

    -- Buffers {{{
    'https://github.com/tpope/vim-eunuch',
    'https://github.com/tpope/vim-abolish',
    'https://github.com/justinmk/vim-dirvish',
    -- }}}

    -- Text {{{
    'https://github.com/rstacruz/vim-closer',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/mattn/emmet-vim',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/rafamadriz/friendly-snippets',
    -- }}}

    -- Syntax {{{
    'https://github.com/vim-scripts/fountain.vim',
    'https://github.com/JafarDakhan/vim-gml',
    -- }}}

    -- Color schemes {{{
    'https://github.com/cormacrelf/dark-notify',
    'https://github.com/lunacookies/vim-colors-xcode',
    -- }}}

})

-- Install Tree Sitter parsers {{{
require('nvim-treesitter').install {
    'awk',
    'bash',
    'c',
    'comment',
    'css',
    'diff',
    'dockerfile',
    'fish',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'hjson',
    'html',
    'htmldjango',
    'http',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'latex',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'mermaid',
    'php',
    'phpdoc',
    'python',
    'regex',
    'rst',
    'rust',
    'scss',
    'swift',
    'sql',
    'ssh_config',
    'toml',
    'tsx',
    'twig',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}
-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4 foldminlines=1
