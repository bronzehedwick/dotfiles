scriptencoding utf-8

" General configuration {{{

" Use soft tabs.
set expandtab

" Soft tabs equal four spaces.
set shiftwidth=4

" Real tabs equal to spaces.
set tabstop=4

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

" Use relative line numbers with the current line the absolute line number.
set number
set relativenumber

" Use a dark background.
set background=dark

" Neovim's standard clipboard register = the system register.
set clipboard+=unnamedplus

" No spell checking.
set nospell

" Prevents inserting two spaces after punctuation on a join (J).
set nojoinspaces

" Puts new vsplit windows to the right of the current.
set splitright

" Puts new split windows to the bottom of the currentset hidden.
set splitbelow

" Show matching brackets/parenthesis.
set showmatch

" Case insensitive search when using any capital letters.
set ignorecase
set smartcase

" Highlight invisible whitespace.
set list

" Allow switching buffers without saving.
set hidden

" Set hard wrapping guide to 80 columns.
set colorcolumn=80

" Show effects of commands incrementally, as you type.
if has('nvim')
  set inccommand=nosplit
endif

" Don't redraw while typing macros.
set lazyredraw

" Update swap file and gitgutter much faster.
set updatetime=250

" Disable mouse, to prevent accidental clicks.
set mouse-=a

" Mandatory setting for mu complete
set completeopt+=menuone

" Disable netrw, since I'm using Dirvish instead.
let g:loaded_netrwPlugin = 1

" AutoPairs
let g:AutoPairsShortcutToggle = ''

" Turn off default Pad plugin mappings.
let g:pad#set_mappings = 0

" Enable FZF
if filereadable('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
endif

" }}}

" Statusline {{{

" Git branch
set statusline=%{fugitive#statusline()}
" Tail of file (just the name.ext)
set statusline+=%<\ %t
" File modified flag
set statusline+=%m
" Buffer is `help` flag
set statusline+=%<\ %h
" Buffer is `readonly` flag
set statusline+=%<\ %r
" Buffer is `preview` flag
set statusline+=%<\ %w

" }}}

" Mappings {{{

" Remap mapleader.
let mapleader = ','
let maplocalleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Stupid shift key fixes, lifted from spf13
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" Disable Ex mode mapping. Can still be accessed via gQ.
nnoremap Q q

" Toggle set wrap
noremap <silent><leader>w :setlocal wrap!<CR>

" Open directory at current file path.
noremap <leader>e :edit <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" More useful window navigation bindings.
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Display date and time
noremap <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Jet-pack movement between buffers…
nnoremap <leader>l :ls<CR>:b<space>
nnoremap <leader>k :ls<CR>:sbuffer<space>
nnoremap <leader>; :ls<CR>:vert sb<space>

" More sane command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Quickly edit macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Terminal
" Escape exits insert mode inside terminal.
tnoremap <Esc> <C-\><C-n>
" M-r pastes inside terminal.
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Insert time into a document.
noremap <F4> <Plug>(Timestamp)<CR>

" }}}

" Autocommands {{{

" Terminal
if has('nvim')
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  autocmd TermOpen * setlocal norelativenumber nonumber
endif

" Chat
autocmd BufEnter term://*chat setlocal nonumber norelativenumber

" NeoMutt
autocmd BufEnter term://*neomutt setlocal nonumber |
      \ setlocal norelativenumber |
      \ setlocal noshowmode |
      \ setlocal noruler |
      \ setlocal laststatus=0 |
      \ setlocal noshowcmd |
      \ autocmd BufLeave <buffer> set laststatus=2 showmode ruler showcmd

" }}}

" Color {{{

" True color!
if has('termguicolors')
  set termguicolors
endif

colorscheme OceanicNext

" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
