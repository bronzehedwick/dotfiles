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
    {
        'lewis6991/gitsigns.nvim',
        function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })
                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })
                    -- Actions
                    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)
                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    },
    -- }}}

    -- Buffers {{{
    'tpope/vim-eunuch',
    'tpope/vim-sleuth',
    'justinmk/vim-dirvish',
    'mbbill/undotree',
    -- }}}

    -- Text {{{
    'editorconfig/editorconfig-vim', -- TODO Remove after nvim 0.9+
    'rstacruz/vim-closer',
    'tpope/vim-surround',
    { 'mattn/emmet-vim', opt = true },
    {
        'nvim-orgmode/orgmode',
        function() require('orgmode').setup {} end
    },
    {
        'numToStr/Comment.nvim',
        function() require('Comment').setup() end
    },
    -- }}}

    -- Terminal {{{
    'bronzehedwick/vim-primary-terminal',
    -- }}}

    -- Syntax {{{
    'vim-scripts/fountain.vim',
    -- }}}

    -- Colorschemes {{{
    'cormacrelf/dark-notify',
    {
        'bronzehedwick/vim-colors-xcode',
        branch = 'lsp-treesitter-highlights'
    },
    -- }}}

}

-- vim:fdm=marker ft=lua et sts=4 sw=4
