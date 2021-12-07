-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'arp242/jumpy.vim'
    use {
      'bronzehedwick/vim-colors-xcode',
      branch = 'lsp-treesitter-highlights'
    }
    use 'cormacrelf/dark-notify'
    use 'dag/vim-fish'
    use 'justinmk/vim-dirvish'
    use 'mbbill/undotree'
    use 'neovim/nvim-lspconfig'
    use 'bronzehedwick/vim-primary-terminal'
    use 'phaazon/hop.nvim'
    use 'rstacruz/vim-closer'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'vim-scripts/fountain.vim'
    use 'whiteinge/diffconflicts'
    use { 'mattn/emmet-vim', opt = true }
    use {
      'kristijanhusak/orgmode.nvim', config = function()
        require('orgmode').setup{}
      end
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'milisims/tree-sitter-org'
    use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

end)
