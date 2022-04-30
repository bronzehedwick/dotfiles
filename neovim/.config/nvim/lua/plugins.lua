-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'justinmk/vim-ipmotion'
    use 'arp242/jumpy.vim'
    use {
      'bronzehedwick/vim-colors-xcode',
      branch = 'lsp-treesitter-highlights'
    }
    use 'cormacrelf/dark-notify'
    use 'justinmk/vim-dirvish'
    use 'mbbill/undotree'
    use 'neovim/nvim-lspconfig'
    use 'bronzehedwick/vim-primary-terminal'
    use 'phaazon/hop.nvim'
    use 'rstacruz/vim-closer'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rsi'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'vim-scripts/fountain.vim'
    use 'whiteinge/diffconflicts'
    use { 'mattn/emmet-vim', opt = true }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-orgmode/orgmode', config = function()
      require('orgmode').setup{}
    end }
    use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

end)
