-- Helpers {{{

local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

-- }}}

-- Re-mappings {{{

-- Set mapleader to ",", keeping localleader as the default "\".
vim.g.mapleader = ','

-- Yank from the cursor to the end of the line, to be consistent with C and D.
map {'n', 'Y', 'y$'}

-- Stupid shift key fixes, lifted from spf13.
vim.cmd [[
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
]]

-- Replace Ex mode mapping with repeat last macro used.
-- Ex mode can still be accessed via gQ.
map {'n', 'Q', '@@'}

-- }}}

-- Interface {{{

-- Use soft tabs.
vim.opt.expandtab = true

-- Soft tabs equal two spaces.
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Keep tab widths default to address possible display issues.
-- see: https://www.reddit.com/r/vim/wiki/tabstop
vim.opt.tabstop = 8

-- No spell checking.
vim.opt.spell = false

-- Prevents inserting two spaces after punctuation on a join (J).
vim.opt.joinspaces = false

-- Case insensitive search when using any capital letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable mouse, to prevent accidental clicks.
vim.opt.mouse = ''

-- Message pager does not fill entire screen.
-- See https://github.com/neovim/neovim/pull/8088
vim.opt.fillchars = 'msgsep:◌'

-- Format text (gq) with par if it exists.
if vim.fn.executable('par') == 1 then
  vim.opt.formatprg = 'par'
end

-- Make the jump-list behave like the tag list or a web browser.
vim.opt.jumpoptions = 'stack'

-- Use ripgrep as external grep tool, if available.
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --no-heading --vimgrep'
end

-- Add mapping to open URLs in the current buffer.
-- TODO: Re-write this in lua.
if vim.fn.executable('urlview') == 1 then
  vim.cmd [[
    function! UrlView() abort
      :startinsert
      :silent write! /tmp/nvim-extract-url.out
      :split term://urlview /tmp/nvim-extract-url.out
    endfunction
    nnoremap <leader>u :call UrlView()<CR>
  ]]
end

-- Automatically open, but do not go to (if there are errors) the quickfix /
-- location list window, or close it when is has become empty.
--
-- Note: Must allow nesting of autocmds to enable any customizations for quickfix
-- buffers.
-- Note: Normally, :cwindow jumps to the quickfix window if the command opens it
-- (but not if it's already open). However, as part of the autocmd, this doesn't
-- seem to happen.
vim.cmd [[
  augroup MakerQuickFix
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
  augroup END
]]

-- Make list-like commands more intuitive.
-- TODO: Re-write this in lua.
vim.cmd [[
  function! CCR()
    let cmdline = getcmdline()
    if cmdline =~# '\v\C^(ls|files|buffers)'
      " Like :ls but prompts for a buffer command.
      return "\<CR>:b"
    elseif cmdline =~# '\v\C/(#|nu|num|numb|numbe|number)$'
      " Like :g//# but prompts for a command.
      return "\<CR>:"
    elseif cmdline =~# '\v\C^(dli|il)'
      " Like :dlist or :ilist but prompts for a count for :djump or :ijump.
      return "\<CR>:" . cmdline[0] . 'j  ' . split(cmdline, ' ')[1] . "\<S-Left>\<Left>"
    elseif cmdline =~# '\v\C^(cli|lli)'
      " Like :clist or :llist but prompts for an error/location number.
      return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~# '\C^old'
      " Like :oldfiles but prompts for an old file to edit.
      set nomore
      return "\<CR>:sil se more|e #<"
    elseif cmdline =~# '\C^changes'
      " Like :changes but prompts for a change to jump to.
      set nomore
      return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~# '\C^ju'
      " Like :jumps but prompts for a position to jump to.
      set nomore
      return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~# '\C^marks'
      " Like :marks but prompts for a mark to jump to.
      return "\<CR>:norm! `"
    elseif cmdline =~# '\C^undol'
      " Like :undolist but prompts for a change to undo.
      return "\<CR>:u "
    else
      return "\<CR>"
    endif
  endfunction
  cnoremap <expr> <CR> CCR()
]]

-- }}}

-- Display {{{

-- Don't redraw while typing macros.
vim.opt.lazyredraw = true

-- Update swap file and gitgutter much faster.
vim.opt.updatetime = 250

-- Command <Tab> completion.
vim.opt.wildmode = { 'longest:full' }

-- Message popup is slightly transparent.
vim.opt.pumblend = 10

-- Higlight invisible whitespace.
vim.opt.list = true

-- Set hard wrapping guide.
vim.opt.colorcolumn = '80'

-- Diff options.
vim.opt.diffopt = {
  'internal',
  'filler',
  'vertical',
  'algorithm:patience',
}

-- Show effects of comman incrementally, as you type.
vim.opt.inccommand = 'nosplit'

-- Make file messages even shorter and messier.
vim.opt.shortmess = 'filnxrtToOF'

-- Turn off search highlight after cursor moved.
-- TODO: rewrite in vimscript.
-- vim.cmd [[
--   noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
--   noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

--   function! HlSearch()
--     let s:pos = match(getline('.'), @/, col('.') - 1) + 1
--     if s:pos != col('.')
--       call StopHL()
--     endif
--   endfunction

--   function! StopHL()
--     if !v:hlsearch || mode() isnot# 'n'
--       return
--     else
--       sil call feedkeys("\<Plug>(StopHL)", 'm')
--     endif
--   endfunction

--   augroup SearchHighlight
--     au!
--     au CursorMoved * call HlSearch()
--     au InsertEnter * call StopHL()
--   augroup end

--   au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
-- ]]

-- }}}

-- Buffers {{{

-- Allow switching buffers without saving.
vim.opt.hidden = true

-- Allow undo
vim.opt.undofile = true

-- Open directory at current file path.
map {'n', '<leader>e', ':edit <C-R>=expand("%:p:h") . "/" <CR>'}
map {'n', '<leader>s', ':split <C-R>=expand("%:p:h") . "/" <CR>'}
map {'n', '<leader>v', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>'}

-- Shortcut to edit this file.
map {'n', '<leader>c', ':edit ~/.dotfiles/neovim/.config/nvim/init.lua<CR>'}

-- }}}

-- Windows {{{

-- Puts new vsplit windows to the right of the current.
vim.opt.splitright = true

-- Puts new split windows to the bottom of the current.
vim.opt.splitbelow = true

-- More useful window navigation bindings.
map {'n', '<C-k>', '<C-w>k'}
map {'n', '<C-j>', '<C-w>j'}
map {'n', '<C-l>', '<C-w>l'}
map {'n', '<C-h>', '<C-w>h'}

-- }}}

-- Command line {{{

-- More sane command-line history.
map {'c', '<C-n>', '<down>'}
map {'c', '<C-p>', '<up>'}

-- }}}

-- Statusline {{{

-- Tail of file (just the name.ext).
vim.opt.statusline = '%< %t'
-- File modified flag.
vim.opt.statusline:append('%m')
-- Buffer has help flag.
vim.opt.statusline:append('%< %h')
-- Buffer has preview flag.
vim.opt.statusline:append('%< %w')
-- New group.
vim.opt.statusline:append('%=')
-- Line number.
vim.opt.statusline:append('%l')
-- New group.
vim.opt.statusline:append('%=')
-- Percentage through the file.
vim.opt.statusline:append('%p%%')

-- }}}

-- Convenience mappings {{{

-- Display date and time.
map {'n', '<F2>', ':echo "It is"' .. vim.fn.strftime('%a %b %e %I:%M %p') .. '<CR>'}

-- }}}

-- Terminal {{{

if vim.fn.executable('/usr/local/bin/bash') then
  vim.opt.shell = '/usr/local/bin/bash'
end

if vim.fn.executable('/usr/local/bin/fish') then
  vim.opt.shell = '/usr/local/bin/fish'
end

vim.cmd [[
  augroup terminal
    autocmd!
    " Set the statusline to the process name set by the terminal.
    autocmd TermOpen * setlocal statusline=%{b:term_title} nonumber
  augroup END
]]

-- Escape exits insert mode inside terminal.
map {'t', '<Esc>', '<C-\\><C-n>'}

-- M-r pastes inside terminal.
-- NOTE: This really slows down init. Not sure why.
-- map {'t', '<expr> <A-r>', '<C-\\><C-N>' .. vim.fn.nr2char(vim.fn.getchar()) .. 'pi'}

-- }}}

-- Plugins {{{

require'plugins'
require'pluginconfig'

-- }}}

-- Colorscheme {{{

vim.opt.background = 'light'
vim.opt.termguicolors = true

-- xcode color theme.
vim.g.xcodelight_green_comments = 1
vim.g.xcodedarkhc_green_comments = 1
vim.g.xcodelight_match_paren_style = 1
vim.g.xcodedarkhc_match_paren_style = 1

vim.cmd('colorscheme xcodelight')

local dn = require('dark_notify')
dn.run({
  schemes = {
    light = 'xcodelight',
    dark = 'xcodedarkhc'
  }
})

-- }}}

-- vim:foldmethod=marker et sts=2 sw=2
