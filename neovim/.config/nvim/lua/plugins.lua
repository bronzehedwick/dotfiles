require 'paq' {
    'savq/paq-nvim', -- Let Paq manage itself

    -- Utilities {{{
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() vim.cmd 'TSUpdate' end
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'tpope/vim-dispatch',
    'justinmk/vim-ipmotion',
    'tpope/vim-repeat',
    'mfussenegger/nvim-dap',
    -- }}}

    -- Movement {{{
    'arp242/jumpy.vim',
    'justinmk/vim-sneak',
    'tpope/vim-rsi',
    'tpope/vim-unimpaired',
    -- }}}

    -- Git {{{
    'tpope/vim-fugitive',
    'tommcdo/vim-fubitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',
    'daliusd/ghlite.nvim',
    -- }}}

    -- Buffers {{{
    'tpope/vim-eunuch',
    'tpope/vim-abolish',
    'justinmk/vim-dirvish',
    'mbbill/undotree',
    'brenoprata10/nvim-highlight-colors',
    -- }}}

    -- Text {{{
    'rstacruz/vim-closer',
    'kylechui/nvim-surround',
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
    'rafamadriz/friendly-snippets',
    -- }}}

    -- Syntax {{{
    'vim-scripts/fountain.vim',
    -- }}}

    -- Colorschemes {{{
    'cormacrelf/dark-notify',
    'ellisonleao/gruvbox.nvim',
    'lunacookies/vim-colors-xcode',
    -- }}}

}

-- vim:fdm=marker ft=lua et sts=4 sw=4
