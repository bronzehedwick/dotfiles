" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/loremipsum'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-sneak'

" Working with the file system
Plug 'cloudhead/neovim-fuzzy' " needs fzy and rg or ag installed
Plug 'kassio/neoterm'
Plug 'tpope/vim-eunuch'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-obsession'

" Programming
Plug 'benekastah/neomake'
if has('python3')
  Plug 'Shougo/deoplete.nvim'
  Plug 'carlitux/deoplete-ternjs'
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'htmldjango', 'html.mustache', 'html.handlebars' ] }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntaxes
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'sass', 'less' ] }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'mustache/vim-mustache-handlebars', { 'for': [ 'mustache', 'handlebars', 'html.mustache', 'html.handlebars' ] }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'sudar/vim-arduino-syntax', { 'for': 'ino' }

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

" Status line
set statusline=%{fugitive#statusline()} " Git branch
set statusline+=%<\ %t " Tail of file (just the name.ext)
set statusline+=%m " File modified flag
set statusline+=%<\ %h " Buffer is `help` flag
set statusline+=%<\ %r " Buffer is `readonly` flag
set statusline+=%<\ %w " Buffer is `preview` flag
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*

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
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

" Open directory at current file path.
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

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

function! WritingConfigs()
  :set textwidth=80
endfunction

""""""""""""""""
" Autocommands "
""""""""""""""""

" Autodetect extra file types
augroup filetypedetect
  " django templates (syntax is built in to vim) are very similar to twig.
  autocmd BufNewFile,BufRead *.twig set filetype=htmldjango
  " Support Drupal .module and .theme files.
  autocmd BufNewFile,BufRead *.theme,*.module set filetype=php
  " Support fountain files
  autocmd BufNew,BufNewFile,BufRead *.fountain :setfiletype fountain
augroup END

" Special configurations for markdown files.
autocmd FileType markdown call WritingConfigs()

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

" Neomake
let g:neomake_open_list=0

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_json_enabled_makers = ['jsonlint']

let g:neomake_twig_twig_lint_makers = {
  \ 'exe': 'twig-lint.phar',
  \ 'args': ['lint'],
  \ }
let g:neomake_twig_twig_lint_makers = ['htmldjango']

let g:neomake_grunt_maker = {
  \ 'exe': 'grunt',
  \ 'args': ['build'],
  \ }

autocmd! BufWritePost * Neomake

" Neoterm
let g:neoterm_shell = 'bash'
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

nnoremap <silent> <leader>th :call neoterm#close()<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tc :call neoterm#kill()<cr>

nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>

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

"""""""""""""""
" Colorscheme "
"""""""""""""""

colorscheme OceanicNext
