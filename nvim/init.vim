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

" Change to the current buffer's parent directory
set autochdir

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

" Set hard wrapping guide to 80 columns
set colorcolumn=80

" Status line
if isdirectory(expand("~/.config/nvim/plugged/vim-fugitive/"))
  set statusline=%{fugitive#statusline()}
endif
set statusline+=%<\ %f

" Remap mapleader
let mapleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Add new insert mode mapping for Esc
:imap jh <Esc>

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
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Cursor is line in insert mode, block in normal mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

"""""""""""""
" Functions "
"""""""""""""

" Display date and time
map <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Insert time into a document
command! -nargs=* Timestamp call Timestamp()
function! Timestamp()
  :r !date "+\%h \%d, \%Y, \%l:\%M:\%S \%p"
endfunction

"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Working with the file system
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Programming
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntaxes
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['handlebars', 'mustache'] }
Plug 'JulesWang/css.vim'
Plug 'vim-scripts/fountain.vim'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'sudar/vim-arduino-syntax', { 'for': 'ino' }

" Themes
Plug 'mhartington/oceanic-next'

call plug#end()

""""""""""""""""""""
" Custom functions "
""""""""""""""""""""

" Check if the working directory is managed in git
function! IsGitRepo()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    return 0
  endif
  return 1
endfunction

"""""""""""""""""""""""""
" Plugin configurations "
"""""""""""""""""""""""""

" Autodetect extra file types
augroup filetypedetect
  autocmd BufNew,BufNewFile,BufRead *.fountain :setfiletype fountain
augroup END

" fzf
nmap <C-P> :GitFiles<cr>
nmap <C-S> :Ag<cr>

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
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_json_enabled_makers = ['jsonlint']

autocmd! BufWritePost * Neomake

"""""""""""""""
" Colorscheme "
"""""""""""""""

colorscheme OceanicNext
