require 'paq' {
    'savq/paq-nvim', -- Let Paq manage itself

    -- Utilities {{{
    'neovim/nvim-lspconfig',
    {
        'nvim-treesitter/nvim-treesitter',
        run = function() vim.cmd 'TSUpdate' end
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'tpope/vim-dispatch',
    'justinmk/vim-ipmotion',
    'tpope/vim-repeat',
    'folke/which-key.nvim',
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
    -- }}}

    -- Buffers {{{
    'tpope/vim-eunuch',
    'tpope/vim-sleuth',
    'justinmk/vim-dirvish',
    'mbbill/undotree',
    -- }}}

    -- Text {{{
    'rstacruz/vim-closer',
    'tpope/vim-surround',
    { 'mattn/emmet-vim', opt = true },
    'nvim-orgmode/orgmode',
    'numToStr/Comment.nvim',
    {
        'L3MON4D3/LuaSnip',
        run = 'make install_jsregexp'
    },
    -- }}}

    -- Syntax {{{
    'vim-scripts/fountain.vim',
    -- }}}

    -- Colorschemes {{{
    'cormacrelf/dark-notify',
    'lunacookies/vim-colors-xcode',
    -- }}}

}

-- vim:fdm=marker ft=lua et sts=4 sw=4
