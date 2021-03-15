-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Simple plugins can be specified as strings
  use 'MaxMEllon/vim-jsx-pretty'
  use 'arzg/vim-colors-xcode'
  use 'bronzehedwick/msmtp-syntax.vim'
  use 'bronzehedwick/vim-primary-terminal'
  use 'cespare/vim-toml'
  use 'chr4/nginx.vim'
  use 'dag/vim-fish'
  use 'freitass/todo.txt-vim'
  use 'justinmk/vim-dirvish'
  use 'justinmk/vim-ipmotion'
  use 'justinmk/vim-sneak'
  use 'mbbill/undotree'
  use 'neovim/nvim-lspconfig'
  use 'othree/html5.vim'
  use 'pangloss/vim-javascript'
  use 'rstacruz/vim-closer'
  use 'srstevenson/vim-picker'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-rsi'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'vim-scripts/fountain.vim'
  use 'whiteinge/diffconflicts'
  use { 'mattn/emmet-vim', opt = true }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'plasticboy/vim-markdown', opt = true }
  use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }
  use { 'andymass/vim-matchup', event = 'VimEnter' }

end)
