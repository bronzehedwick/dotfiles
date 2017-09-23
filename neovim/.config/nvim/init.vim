"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-ipmotion'
Plug 'xolox/vim-misc'
Plug 'freitass/todo.txt-vim'
Plug 'mikewest/vimroom'

" Working with the file system
Plug 'cloudhead/neovim-fuzzy' " needs fzy and rg or ag installed
Plug 'kassio/neoterm'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-grepper'
Plug 'sjl/gundo.vim'
Plug 'jamessan/vim-gnupg'
Plug 'vim-scripts/utl.vim'
Plug 'fmoralesc/vim-pad'

" Programming
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'htmldjango', 'html.mustache', 'html.handlebars' ] }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'

" Syntaxes
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'sass', 'less' ] }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'kchmck/vim-coffee-script', { 'for': [ 'coffee', 'eruby' ] }

" Themes
Plug 'mhartington/oceanic-next'

call plug#end()

""""""""""""""""""
" Configurations "
""""""""""""""""""

" Use soft tabs
set expandtab

" Soft tabs equal two spaces
set shiftwidth=2

" Real tabs equal to spaces
set tabstop=2

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

" Use relative line numbers with the current line the absolute line number
set number
set relativenumber

" Use a dark background
set background=dark

" Neovim's standard clipboard register = the system register
set clipboard+=unnamedplus

" No spell checking
" TODO: Turn on spell check for certain file types
set nospell

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces

" Puts new vsplit windows to the right of the current
set splitright

" Puts new split windows to the bottom of the currentset hidden
set splitbelow

" Show matching brackets/parenthesis
set showmatch

" Case insensitive search
set ignorecase

" Highlight invisible whitespace
set list

" Allow switching buffers without saving
set hidden

" Set hard wrapping guide to 80 columns
set colorcolumn=80

" Show effects of commands incrementally, as you type.
set inccommand=nosplit

" Don't redraw while typing macros
set lazyredraw

" Disable netrw, since I'm using Dirvish instead.
let g:loaded_netrwPlugin = 1

" Status line
set statusline=%{fugitive#statusline()} " Git branch
set statusline+=%<\ %t " Tail of file (just the name.ext)
set statusline+=%m " File modified flag
set statusline+=%<\ %h " Buffer is `help` flag
set statusline+=%<\ %r " Buffer is `readonly` flag
set statusline+=%<\ %w " Buffer is `preview` flag

" Disable mouse, to prevent accidental clicks
set mouse-=a

" Remap mapleader
let mapleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Esc exits insert mode in Neovim terminal
tnoremap <Esc> <C-\><C-n>

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

" True color!
if has('termguicolors')
  set termguicolors
endif

" Cursor is line in insert mode, block in normal mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

" Open directory at current file path.
map <leader>e :edit <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" More useful window navigation bindings.
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h

"""""""""""""
" Functions "
"""""""""""""

" Display date and time
map <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Insert time into a document
command! -nargs=* Timestamp call Timestamp()
function! Timestamp()
  :r !date "+\%Y-\%m-\%dT\%T\%z"
endfunction

""""""""""""""""
" Autocommands "
""""""""""""""""

" Autodetect extra file types

" django templates (syntax is built in to vim) are very similar to twig.
autocmd BufRead,BufNewFile *.twig setlocal filetype=htmldjango
" Support Drupal .module and .theme files.
autocmd BufRead,BufNewFile *.theme setlocal filetype=php
autocmd BufRead,BufNewFile *.module setlocal filetype=php
" Support fountain files.
autocmd BufRead,BufNewFile *.fountain setlocal filetype=fountain
" Hard wrap markdown files.
autocmd FileType markdown setlocal textwidth=80

" Terminal
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert

"""""""""""""""""""""""""
" Plugin configurations "
"""""""""""""""""""""""""

" Fuzzy
nnoremap <leader>/ :FuzzyOpen<CR>

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
let g:fugitive_gitlab_domains = ['https://plvmskgitlab1/']

" Neoterm
let g:neoterm_shell = 'bash'
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_autoscroll = 1

function! ToggleNeotermPosition()
  if g:neoterm_position == 'horizontal'
    :Tpos vertical
  else
    :Tpos horizontal
  endif
endfunction
command! -nargs=* ToggleNeotermPosition call ToggleNeotermPosition()

nnoremap <silent> <leader>to :Ttoggle<cr>
nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tc :call neoterm#kill()<cr>
nnoremap <silent> <leader>tp :call ToggleNeotermPosition()<cr>

" EditorConfig
" Disable editorconfig on fugitive and remote buffers.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Dirvish
autocmd FileType dirvish call fugitive#detect(@%)

" Grepper
nnoremap <leader>p :Grepper<cr>
nnoremap <leader>* :Grepper -cword -noprompt<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" let g:grepper.tools += ['rgt']
" let g:grepper.rgt = {
"   \ 'grepprg': 'rg -H --no-heading --vimgrep --type-add "%:e:*.%:e" -t%:e',
"   \ 'grepformat': '%f:%l:%c:%m',
"   \ 'escape': '\^$.*+?()[]{}|',
"   \ }
let g:grepper = {
  \ 'tools': ['rg', 'git']
  \ }

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Vimroom
" disable vertical padding.
let g:vimroom_sidebar_height = 0

" Pad (Notes)
let g:pad#dir = '~/ownCloud/notepad'

"""""""""""""""
" Colorscheme "
"""""""""""""""

colorscheme OceanicNext
