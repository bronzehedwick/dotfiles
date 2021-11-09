-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'MaxMEllon/vim-jsx-pretty'
    use 'arp242/jumpy.vim'
    use 'arzg/vim-colors-xcode'
    -- use 'bronzehedwick/msmtp-syntax.vim'
    -- use 'chr4/nginx.vim'
    use 'cormacrelf/dark-notify'
    use 'dag/vim-fish'
    use 'folke/lsp-colors.nvim'
    use 'justinmk/vim-dirvish'
    use 'justinmk/vim-ipmotion'
    use 'mbbill/undotree'
    use 'neovim/nvim-lspconfig'
    use 'numtostr/FTerm.nvim'
    use 'othree/html5.vim'
    use 'pangloss/vim-javascript'
    use 'phaazon/hop.nvim'
    use 'rstacruz/vim-closer'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'vim-scripts/fountain.vim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'whiteinge/diffconflicts'
    use { 'mattn/emmet-vim', opt = true }
    use {
      'kristijanhusak/orgmode.nvim', config = function()
        require('orgmode').setup{}
      end
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'milisims/tree-sitter-org'
    use { 'plasticboy/vim-markdown', opt = true }
    use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

end)
