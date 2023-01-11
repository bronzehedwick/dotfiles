local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

ensure_packer()

-- Only required since I have packer in my `opt` pack.
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself as an optional plugin {{{
  use { 'wbthomason/packer.nvim', opt = true }
  -- }}}

  -- Utilities {{{
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
  }
  use 'justinmk/vim-ipmotion'
  use 'tpope/vim-repeat'
  -- }}}

  -- Movement {{{
  use 'arp242/jumpy.vim'
  use 'justinmk/vim-sneak'
  use 'tpope/vim-rsi'
  use 'tpope/vim-unimpaired'
  -- }}}

  -- Git {{{
  use 'tpope/vim-fugitive'
  use 'tommcdo/vim-fubitive'
  use 'tpope/vim-rhubarb'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
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
  }
  -- }}}

  -- Buffers {{{
  use 'tpope/vim-eunuch'
  use 'tpope/vim-sleuth'
  use 'justinmk/vim-dirvish'
  use 'mbbill/undotree'
  -- }}}

  -- Text {{{
  use 'rstacruz/vim-closer'
  use 'tpope/vim-surround'
  use {
    'mattn/emmet-vim',
    opt = true
  }
  use { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup {}
  end }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- }}}

  -- Terminal {{{
  use 'bronzehedwick/vim-primary-terminal'
  -- }}}

  -- Syntax {{{
  use 'vim-scripts/fountain.vim'
  -- }}}

  -- Colorschemes {{{
  use 'cormacrelf/dark-notify'
  use {
    'bronzehedwick/vim-colors-xcode',
    branch = 'lsp-treesitter-highlights'
  }
  -- }}}

end)

-- vim: foldmethod=marker
