require 'paq' {
    'savq/paq-nvim', -- Let Paq manage itself

    -- Utilities {{{
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() vim.cmd 'TSUpdate' end
    },
    'nvim-treesitter/nvim-treesitter-context',
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'RRethy/nvim-treesitter-endwise',
    'tpope/vim-dispatch',
    'justinmk/vim-ipmotion',
    'tpope/vim-repeat',
    -- }}}

    -- Movement {{{
    'tpope/vim-rsi',
    'tpope/vim-unimpaired',
    'leath-dub/snipe.nvim',
    'ggandor/leap.nvim',
    -- }}}

    -- Git {{{
    'tpope/vim-fugitive',
    'tommcdo/vim-fubitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',
    -- }}}

    -- Buffers {{{
    'tpope/vim-eunuch',
    'tpope/vim-abolish',
    'justinmk/vim-dirvish',
    'mbbill/undotree',
    -- }}}

    -- Text {{{
    'rstacruz/vim-closer',
    'kylechui/nvim-surround',
    { 'mattn/emmet-vim', opt = true },
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
    'rafamadriz/friendly-snippets',
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    -- }}}

    -- Syntax {{{
    'vim-scripts/fountain.vim',
    'JafarDakhan/vim-gml',
    -- }}}

    -- Color schemes {{{
    'cormacrelf/dark-notify',
    'ellisonleao/gruvbox.nvim',
    'lunacookies/vim-colors-xcode',
    'projekt0n/github-nvim-theme',
    -- }}}

}

-- vim:fdm=marker ft=lua et sts=4 sw=4 foldminlines=1
