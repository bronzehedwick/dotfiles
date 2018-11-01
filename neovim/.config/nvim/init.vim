" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
scriptencoding utf-8

" Plugins {{{

" Install vim-plug if it's not present on the system. {{{
if !filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo "~/.config/nvim/autoload/plug.vim" --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
" }}}

" Working with text {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-ipmotion'
Plug 'tpope/vim-abolish'
Plug 'junegunn/goyo.vim'
" }}}

" Working with the file system {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-grepper'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'jamessan/vim-gnupg'
Plug 'fmoralesc/vim-pad', { 'branch': 'devel' }
Plug 'vim-scripts/utl.vim'
" }}}

" Programming {{{
Plug 'neomake/neomake'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'htmldjango', 'html.mustache', 'html.handlebars', 'twig', 'html.twig' ] }
Plug 'janko-m/vim-test'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'roxma/LanguageServer-php-neovim',  { 'do': 'composer install && composer run-script parse-stubs' }
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2', { 'do': ':UpdateRemotePlugins' }
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
Plug 'yuki-ycino/ncm2-dictionary'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-html-subscope'
Plug 'ncm2/ncm2-markdown-subscope'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'
" }}}

" Syntaxes {{{
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'sass', 'less' ] }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'lumiliet/vim-twig', { 'for': [ 'twig', 'html.twig' ] }
Plug 'bronzehedwick/msmtp-syntax.vim'
" }}}

" Themes
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'

call plug#end()

" }}}

" Configurations {{{

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

" Case insensitive search when using any capital letters
set ignorecase
set smartcase

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

" Update swap file and gitgutter much faster.
set updatetime=250

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

" Alt+r to paste in terminal mode
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

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

" True color!
if has('termguicolors')
  set termguicolors
endif

" Toggle set wrap
nmap <silent><leader>w :setlocal wrap!<CR>

" Open directory at current file path.
map <leader>e :edit <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" More useful window navigation bindings.
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Jet-pack movement between buffers…
nnoremap <leader>l :ls<CR>:b<space>
nnoremap <leader>k :ls<CR>:sbuffer<space>
nnoremap <leader>; :ls<CR>:vert sb<space>

" More sane command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Quickly edit macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Quickly open URLs
nnoremap <leader>u :Utl<cr>
" Configure HTTP handler (works for macOS).
let g:utl_cfg_hdl_scm_http_system = "silent !open '%u'"
" }}}

" Functions {{{

" Display date and time
map <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Insert time into a document
command! -nargs=* Timestamp call Timestamp()
function! Timestamp()
  let my_filetype = &filetype
  if my_filetype == 'fountain'
    :r !date "+\%m/\%d/\%Y"
  else
    :r !date "+\%Y-\%m-\%dT\%T\%z"
  endif
endfunction
nmap <F4> call Timestamp()

" }}}

" Autocommands {{{

" Autodetect extra file types

" Support Drupal .module and .theme files.
autocmd BufRead,BufNewFile *.theme setlocal filetype=php
autocmd BufRead,BufNewFile *.module setlocal filetype=php
" Support fountain files.
autocmd BufRead,BufNewFile *.fountain setlocal filetype=fountain

" Terminal
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" NeoMutt
autocmd BufEnter term://*neomutt setlocal nonumber
autocmd BufEnter term://*neomutt setlocal norelativenumber
autocmd BufEnter mail setlocal fo+=aw

" Chat
autocmd BufEnter term://*chat setlocal nonumber
autocmd BufEnter term://*chat setlocal norelativenumber

" Spelling
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType text setlocal spell
autocmd FileType fountain setlocal spell
autocmd BufEnter mail setlocal spell
autocmd FileType help setlocal nospell

" }}}

" Plugin configurations {{{

" AutoPairs {{{
let g:AutoPairsShortcutToggle = ''
" }}}

" FZF {{{
nnoremap <M-/> :FZF<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}

" Fugitive {{{
nnoremap <silent> <M-g>s :Gstatus<CR>
nnoremap <silent> <M-g>d :Gdiff<CR>
nnoremap <silent> <M-g>c :Gcommit<CR>
nnoremap <silent> <M-g>b :Gblame<CR>
nnoremap <silent> <M-g>l :Glog<CR>
nnoremap <silent> <M-g>p :Git push<CR>
nnoremap <silent> <M-g>r :Gread<CR>
nnoremap <silent> <M-g>w :Gwrite<CR>
nnoremap <silent> <M-g>e :Gedit<CR>
nnoremap <silent> <M-g>u :Git up<CR>
let g:fugitive_gitlab_domains = ['https://plvmskgitlab1/']
" }}}

" EditorConfig {{{
" Disable editorconfig on fugitive and remote buffers.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}

" Vim-Test {{{
let test#strategy = "neovim"
" }}}

" Dirvish {{{
autocmd FileType dirvish call fugitive#detect(@%)
" }}}

" Grepper {{{
nnoremap <M-p> :Grepper<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
let g:grepper = {
      \ 'tools': ['rg', 'rgsass', 'rgtwig', 'rgjs', 'rgphp'],
      \ 'rgsass': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -tsass',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgtwig': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -ttwig',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgjs': {
      \   'grepprg': 'rg -H --no-heading --vimgrep -tjs',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ },
      \ 'rgphp': {
      \   'grepprg': 'rg -H --no-heading --vimgrep --type-add="module:*.module" --type-add="theme:*.theme" -tphp -tmodule -ttheme',
      \   'grepformat': '%f:%l:%c:%m',
      \   'escape': '\^$.*+?()[]{}|',
      \ }}
" }}}

" Undotree {{{
nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
  set undodir=~/.config/nvim/undodir
  set undofile
endif
" }}}

" Neomake {{{
call neomake#configure#automake('w')
" }}}

" Pad (Notes) {{{
let g:pad#dir = '~/Nextcloud/Notes'
let g:pad#default_file_extension = '.md'
" }}}

" Language Server {{{
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}
"" LSP JavaScript
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed\n"
  :cq
endif
"" LSP Rust
if executable('rustup')
  let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
  autocmd FileType rust setlocal omnifunc=LanguageClient#complete
else
  echo "rust not installed\n"
  :cq
endif
"" LSP CSS
if executable('css-languageserver')
  let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.scss = ['css-languageserver', '--stdio']
  autocmd FileType css setlocal omnifunc=LanguageClient#complete
  autocmd FileType scss setlocal omnifunc=LanguageClient#complete
else
  echo "vscode-css-languageservice not installed\n"
  :cq
endif
"" LSP keymaps
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F3> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <M-s> :call LanguageClient_textDocument_documentSymbol()<CR>
" }}}

" NCM2 (completion manager) {{{
autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" }}}

" Neovim remote {{{
if has('nvim') && executable('nvr')
  let $VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
" }}}

" }}}

" Colorscheme {{{

colorscheme onedark

" }}}
