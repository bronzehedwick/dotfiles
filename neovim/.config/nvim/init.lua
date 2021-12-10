-- Helpers {{{

local map = require'utilities'.map
local create_augroups = require'utilities'.create_augroups
local autocmds = {}

-- }}}

-- Re-mappings {{{

-- Set mapleader to ",", keeping localleader as the default "\".
vim.g.mapleader = ','

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
vim.o.tabstop = 8

-- No spell checking.
vim.o.spell = false

-- Prevents inserting two spaces after punctuation on a join (J).
vim.o.joinspaces = false

-- Case insensitive search when using any capital letters.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Disable mouse, to prevent accidental clicks.
vim.o.mouse = ''

-- Message pager does not fill entire screen.
-- See https://github.com/neovim/neovim/pull/8088
vim.o.fillchars = 'msgsep:◌'

-- Format text (gq) with par if it exists.
if vim.fn.executable('par') == 1 then
  vim.opt.formatprg = 'par'
end

-- Make the jump-list behave like the tag list or a web browser.
vim.o.jumpoptions = 'stack'

-- Use ripgrep as external grep tool, if available.
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --no-heading --vimgrep'
end

-- Add mapping to open URLs in the current buffer.
if vim.fn.executable('urlview') == 1 then
  UrlView = function()
    vim.api.nvim_command('startinsert')
    vim.api.nvim_command('write! /tmp/nvim-extract-url.out')
    vim.api.nvim_command('split term://urlview /tmp/nvim-extract-url.out')
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
vim.o.lazyredraw = true

-- Update swap file and gitgutter much faster.
vim.o.updatetime = 250

-- Command <Tab> completion.
vim.o.wildmode = 'longest:full'

-- Message popup is slightly transparent.
vim.o.pumblend = 10

-- Higlight invisible whitespace.
vim.o.list = true

-- Set hard wrapping guide.
vim.o.colorcolumn = '80'

-- Diff options.
vim.o.diffopt = 'internal,filler,vertical,algorithm:patience'

-- Show effects of comman incrementally, as you type.
vim.o.inccommand = 'nosplit'

-- Make file messages even shorter and messier.
vim.o.shortmess = 'filnxrtToOF'

-- Turn off search highlight after cursor moved.
-- vim.cmd [[
--   noremap <expr> <Plug>(StopHl) execute('nohlsearch')[-1]
--   noremap! <expr> <Plug>(StopHl) execute('nohlsearch')[-1]

---   function! HlSearch()
---     let s:pos = match(getline('.'), @/, col('.') - 1) + 1
---     if s:pos != col('.')
---       call StopHL()
---     endif
---   endfunction

---   function! StopHL()
---     if !v:hlsearch || mode() isnot# 'n'
---       return
---     else
---       sil call feedkeys("\<Plug>(StopHL)", 'm')
---     endif
---   endfunction

--   augroup SearchHighlight
--     au!
--     au CursorMoved * call HlSearch()
--     au InsertEnter * call StopHl()
--   augroup end

--   au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
-- ]]

function StopHl()
  if (vim.v.hlsearch == 0 or not vim.fn.mode() == 'n') then
    return
  else
    vim.opt.hlsearch = false
    -- vim.fn.feedkeys('<Plug>(StopHl)', 'm')
  end
end

function HLSearch()
  local pos = vim.fn.match(vim.fn.getline('.'), '@/', vim.fn.col('.') - 1) + 1
  if (not pos == vim.fn.col('.')) then
    StopHl()
  end
end

-- vim.cmd [[
--   noremap <expr> <Plug>(StopHl) execute('nohlsearch')[-1]
--   noremap! <expr> <Plug>(StopHl) execute('nohlsearch')[-1]
-- ]]

-- autocmds.SearchHighlight = {
--   {'CursorMoved', '*', 'lua HLSearch()'},
--   {'InsertEnter', '*', 'lua StopHl()'},
-- }

-- }}}

-- Buffers {{{

-- Allow switching buffers without saving.
vim.o.hidden = true

-- Allow undo
vim.o.undofile = true

-- Open directory at current file path.
map {'n', '<Leader>e', ':edit <C-R>=expand("%:p:h") . "/" <CR>'}
map {'n', '<Leader>s', ':split <C-R>=expand("%:p:h") . "/" <CR>'}
map {'n', '<Leader>v', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>'}

-- Shortcut to edit this file.
map {'n', '<Leader>c', ':edit ~/.dotfiles/neovim/.config/nvim/init.lua<CR>'}

-- }}}

-- Windows {{{

-- Puts new vsplit windows to the right of the current.
vim.o.splitright = true

-- Puts new split windows to the bottom of the current.
vim.o.splitbelow = true

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

-- Re-map omni-complete to command line complete. I don't use command line
-- complete, and <C-X><C-O> is hard to type on my 34-key keyboard.
map {'i', '<C-V>', '<C-X><C-O>'}

-- Display date and time.
map {'n', '<F2>', '<cmd>lua print("It is " .. vim.fn.strftime("%a %b %e %I:%M %p"))<CR>'}

-- Quickly edit macros.
map { 'n', '<leader>m',  ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>" }

-- Insert time into a document.
map {'i', '<C-g><C-t>', '<C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>'}

-- Clear the highlighting of hlsearch.
if (vim.fn.has('nvim-0.6') == 0) then
  map {'n', '<C-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", silent = true}
end

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

-- Add command to open mail.
Mail = function()
  vim.api.nvim_command('startinsert')
  vim.cmd('edit term://neomutt')
end
vim.cmd [[
  command! Mail lua Mail()<CR>
]]

-- Add command to run prettier over a file, if the tool is present
Prettier = function()
  if vim.fn.filereadable('./node_modules/prettier/bin-prettier.js') == 1 then
    vim.cmd [[
      :%!./node_modules/prettier/bin-prettier.js --stdin-filepath %:p
    ]]
  else
    print('Prettier not found')
  end
end
vim.cmd('command! Prettier lua Prettier()<CR>')

-- Simple fuzzy finding.
map {'n', '<M-/>', "<cmd>lua require'fuzzy-search'.FuzzySearch('git ls-files', 'edit')<CR>"}

-- }}}

-- Terminal {{{

if vim.fn.executable('/usr/local/bin/bash') then
  vim.o.shell = '/usr/local/bin/bash'
end

if vim.fn.executable('/usr/local/bin/fish') then
  vim.o.shell = '/usr/local/bin/fish'
end

-- Set the statusline to the process name set by the terminal.
autocmds.terminal = {
  {'TermOpen', '*', 'setlocal statusline=%{b:term_title} nonumber'},
}

vim.cmd[[
  nmap <unique> <silent> <C-s> <Plug>(PrimaryTerminalOpenSplit)
  tmap <unique> <silent> <C-s> <C-\><C-n><C-w>c
  autocmd TermOpen * startinsert
  autocmd BufEnter term://* startinsert
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

vim.o.background = 'light'
vim.o.termguicolors = true

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

-- vim:fdm=marker ft=lua et sts=2 sw=2
