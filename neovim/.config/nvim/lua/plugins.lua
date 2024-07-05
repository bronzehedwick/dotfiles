require 'paq' {
    'savq/paq-nvim', -- Let Paq manage itself

    -- Utilities {{{
    'nvim-lua/plenary.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() vim.cmd 'TSUpdate' end
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'tpope/vim-dispatch',
    'justinmk/vim-ipmotion',
    'tpope/vim-repeat',
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
    'sindrets/diffview.nvim',
    -- }}}

    -- Buffers {{{
    'tpope/vim-eunuch',
    'tpope/vim-sleuth',
    'tpope/vim-abolish',
    'justinmk/vim-dirvish',
    'mbbill/undotree',
    'NvChad/nvim-colorizer.lua',
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
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
    'nomnivore/ollama.nvim',
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
