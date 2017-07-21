" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-rsi'
Plug 'justinmk/vim-ipmotion'

" Working with the file system
Plug 'cloudhead/neovim-fuzzy' " needs fzy and rg or ag installed
Plug 'kassio/neoterm'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-grepper'
Plug 'sjl/gundo.vim'

" Programming
" Plug 'benekastah/neomake'
Plug 'w0rp/ale'
if has('python3')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'htmldjango', 'html.mustache', 'html.handlebars' ] }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'shumphrey/fugitive-gitlab.vim'

" Syntaxes
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'sass', 'less' ] }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'kchmck/vim-coffee-script', { 'for': [ 'coffee', 'eruby' ] }

" Themes
Plug 'mhartington/oceanic-next'
Plug 'bluz71/vim-moonfly-colors'

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

" Spell checking
set spell

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
autocmd BufNew,BufNewFile,BufRead *.twig set filetype=htmldjango
" Support Drupal .module and .theme files.
autocmd BufNew,BufNewFile,BufRead *.theme,*.module set filetype=php
" Support fountain files.
autocmd BufNew,BufNewFile,BufRead *.fountain :set filetype=fountain
" Hard wrap markdown files.
autocmd FileType markdown :setlocal textwidth=80

" Terminal
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert

"""""""""""""""""""""""""
" Plugin configurations "
"""""""""""""""""""""""""

" Fuzzy
nnoremap <C-p> :FuzzyOpen<CR>

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

nnoremap <silent> <leader>to :call neoterm#open()<cr>
nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tc :call neoterm#kill()<cr>

" EditorConfig
" Disable editorconfig on fugitive and remote buffers.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Deoplete / Tern
if has('python3')
  let g:deoplete#enable_at_startup = 1

  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  " let g:deoplete#disable_auto_complete = 1
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  let g:tern_request_timeout = 1
  let g:tern_show_signature_in_pum = 1
endif

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Dirvish
autocmd FileType dirvish call fugitive#detect(@%)

" Grepper
nnoremap <leader>p :Grepper<cr>
nnoremap <leader>* :Grepper -cword -noprompt<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

let g:grepper = {
  \ 'tools': ['rg', 'git', 'ag', 'ack', 'grep', 'pt', 'findstr']
  \ }

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

"""""""""""""""
" Colorscheme "
"""""""""""""""

" colorscheme OceanicNext
colorscheme moonfly
