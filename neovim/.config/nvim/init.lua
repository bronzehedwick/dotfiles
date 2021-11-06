-- Helpers {{{

local map = require'utilities'.map
local create_augroups = require'utilities'.create_augroups
local autocmds = {}

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
  UrlView = function()
    vim.api.nvim_command('startinsert')
    vim.cmd('split term://urlview ' .. vim.fn.expand('%:p'))
  end
  map {'n', '<Leader>u', '<cmd>lua UrlView()<CR>', silent = true}
end

-- Automatically open, but do not go to (if there are errors) the quickfix /
-- location list window, or close it when is has become empty.
--
-- Note: Must allow nesting of autocmds to enable any customizations for quickfix
-- buffers.
-- Note: Normally, :cwindow jumps to the quickfix window if the command opens it
-- (but not if it's already open). However, as part of the autocmd, this doesn't
-- seem to happen.
autocmds.MakerQuickFix = {
  {'QuickFixCmdPost', '[^l]*', 'nested cwindow'},
  {'QuickFixCmdPost', 'l*', 'nested lwindow'},
}

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
map {'n', '<F2>', '<cmd>lua print("It is " .. vim.fn.strftime("%a %b %e %I:%M %p"))<CR>'}

-- Quickly edit macros.
map { 'n', '<leader>m',  ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>" }

-- Insert time into a document.
map {'i', '<C-g><C-t>', '<C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'}

-- Clear the highlighting of hlsearch.
map {'n', '<M-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", silent = true}

-- Strip trailing whitespace.
map {'n', '<F5>', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>', silent = true}

-- Add customized Grep that's silent and doesn't jump to the first result.
vim.cmd [[
  command! -nargs=+ Grep execute 'silent grep! <args>'
]]

-- Add command to open a git mergetool window.
vim.cmd [[
  command! MergeTool execute 'edit term://git\ mergetool'
]]

-- Add command to run prettier over a file, if the tool is present
prettier = function()
  if vim.fn.filereadable('./node_modules/prettier/bin-prettier.js') == 1 then
    vim.cmd [[
      :%!./node_modules/prettier/bin-prettier.js --stdin-filepath %:p
    ]]
  else
    print('Prettier not found')
  end
end
map {'n', 'gp', '<cmd>lua prettier()<CR>'}

-- }}}

-- Terminal {{{

if vim.fn.executable('/usr/local/bin/bash') then
  vim.opt.shell = '/usr/local/bin/bash'
end

if vim.fn.executable('/usr/local/bin/fish') then
  vim.opt.shell = '/usr/local/bin/fish'
end

-- Set the statusline to the process name set by the terminal.
autocmds.terminal = {
  {'TermOpen', '*', 'setlocal statusline=%{b:term_title} nonumber'},
}

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
vim.g.xcodedarkhc_match_paren_style = 0

vim.cmd('colorscheme xcodelight')

local dn = require('dark_notify')
dn.run({
  schemes = {
    light = 'xcodelight',
    dark = 'xcodedarkhc'
  }
})

vim.cmd [[
  function! MyOrgHighlights() abort
    hi link OrgAgendaDeadline ErrorMsg
    hi link OrgAgendaScheduled DiffChange
    hi link OrgAgendaScheduledPast Warning
  endfunction
  augroup MyOrgColors
    autocmd!
    autocmd ColorScheme * call MyOrgHighlights()
  augroup END
]]

-- Create all augroups
create_augroups(autocmds)

-- }}}

-- vim:foldmethod=marker et sts=2 sw=2
