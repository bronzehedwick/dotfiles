scriptencoding utf-8

" Plugins {{{1

function! PackInit() abort
  " Initialize minpac. {{{2
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  "}}}

  " Working with text. {{{2
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-rsi')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('rstacruz/vim-closer')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('justinmk/vim-ipmotion')
  call minpac#add('freitass/todo.txt-vim')
  call minpac#add('tpope/vim-jdaddy', {'type': 'opt'})
  call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})
  " }}}

  " Working with the file system. {{{2
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('justinmk/vim-dirvish')
  call minpac#add('srstevenson/vim-picker')
  " }}}

  " Programming. {{{2
  call minpac#add('mattn/emmet-vim', {'type': 'opt'})
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('bronzehedwick/vim-primary-terminal')
  call minpac#add('mbbill/undotree')
  " }}}

  " Version control. {{{2
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tommcdo/vim-fubitive')
  call minpac#add('whiteinge/diffconflicts')
  call minpac#add('tpope/vim-rhubarb')
  " }}}

  " Syntaxes. {{{2
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('othree/html5.vim')
  call minpac#add('JulesWang/css.vim')
  call minpac#add('vim-scripts/fountain.vim')
  call minpac#add('cespare/vim-toml')
  call minpac#add('bronzehedwick/msmtp-syntax.vim')
  call minpac#add('beyondwords/vim-twig')
  call minpac#add('chr4/nginx.vim')
  call minpac#add('MaxMEllon/vim-jsx-pretty')
  call minpac#add('dag/vim-fish')
  " }}}

  " Themes. {{{2
  call minpac#add('NLKNguyen/papercolor-theme')
  " }}}
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" }}}

" Re-mappings {{{

" Remap mapleader.
let mapleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Stupid shift key fixes, lifted from spf13.
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" Replace Ex mode mapping with repeat last macro used.
" Ex mode can still be accessed via gQ.
nnoremap Q @@

" }}}

" Interface {{{

" Use soft tabs.
set expandtab

" Soft tabs equal two spaces.
set shiftwidth=2

" Keep tab widths default to address possible display issues.
" see: https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8

" No spell checking.
set nospell

" Prevents inserting two spaces after punctuation on a join (J).
set nojoinspaces

" Case insensitive search when using any capital letters.
set ignorecase
set smartcase

" Disable mouse, to prevent accidental clicks.
set mouse-=a

" Format text (gq) with par if it exists.
if executable('par')
  set formatprg=par
endif

" Use ripgrep as external grep tool if available.
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
endif

if executable('extract_url')
  function! ExtractUrl() abort
    :startinsert
    :silent write! /tmp/nvim-extract-url.out
    :split term://extract_url /tmp/nvim-extract-url.out
  endfunction
  nnoremap <leader>u :call ExtractUrl()<CR>
endif

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
augroup MakerQuickFix
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" }}}

" Display {{{

" Don't redraw while typing macros.
set lazyredraw

" Update swap file and gitgutter much faster.
set updatetime=250

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

" Highlight invisible whitespace.
set list

" Set hard wrapping guide.
set colorcolumn=80

" Highlight the current line.
set cursorline

" Diff options.
set diffopt=internal,filler,vertical,algorithm:patience

" Show effects of commands incrementally, as you type.
if has('nvim')
  set inccommand=nosplit
endif

" }}}

" Buffers {{{

" Allow switching buffers without saving.
set hidden

" Allow undo
set undofile

" Open directory at current file path.
noremap <leader>e :edit <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" Shortcut to edit this file.
noremap <silent><leader>c :edit ~/.dotfiles/neovim/.config/nvim/init.vim<CR>

" Shortcut to edit todo.txt file.
noremap <silent><leader>d :edit ~/Documents/tasks/todo.txt<CR>

" }}}

" Windows {{{

" Puts new vsplit windows to the right of the current.
set splitright

" Puts new split windows to the bottom of the currentset hidden.
set splitbelow

" More useful window navigation bindings.
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" }}}

" Command line {{{

" More sane command-line history.
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" }}}

" Statusline {{{

" Git branch.
set statusline=%{FugitiveStatusline()}
" Tail of file (just the name.ext).
set statusline+=%<\ %t
" File modified flag.
set statusline+=%m
" Buffer is `help` flag.
set statusline+=%<\ %h
" Buffer is `readonly` flag.
set statusline+=%<\ %r
" Buffer is `preview` flag.
set statusline+=%<\ %w
" New group.
set statusline+=%=
" Line and column number.
set statusline+=%l,%v
" New group.
set statusline+=%=
" Percentage through the file.
set statusline+=%p%%

" }}}

" Convenience Mappings {{{

" Display date and time.
noremap <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Quickly edit macros.
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Insert time into a document.
inoremap <C-g><C-t> <C-r>=strftime("%Y-%m-%dT%H:%M:%S")<cr>

" Clear the highlighting of hlsearch.
nnoremap <silent> <M-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>

" Add customized Grep that's silent and doesn't jump to the first result.
command! -nargs=+ Grep execute 'silent grep! <args>'

" }}}

" Terminal {{{

if has('nvim')
  augroup terminal
    autocmd!
    " Set the statusline to the process name set by the terminal.
    autocmd TermOpen * setlocal statusline=%{b:term_title} nonumber
  augroup END
  " Escape exits insert mode inside terminal.
  tnoremap <Esc> <C-\><C-n>
  " M-r pastes inside terminal.
  tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  " Switch to primary terminal buffer.
  nmap <unique> <silent> <leader>t <Plug>(PrimaryTerminalOpen)
  nmap <unique> <silent> <leader>r <Plug>(PrimaryTerminalOpenSplit)
  nmap <unique> <silent> <leader>y <Plug>(PrimaryTerminalOpenVsplit)
endif

if exists('g:started_by_firenvim')
  augroup firenvim
    autocmd!
    autocmd BufEnter github.com_*.txt set filetype=markdown
    autocmd BufEnter jsfiddle.net__editor-DIV-1-DIV-1-DIV-2.txt set filetype=html
    autocmd BufEnter jsfiddle.net__editor-DIV-1-DIV-3-DIV-2.txt set filetype=javascript
    autocmd BufEnter jsfiddle.net__editor-DIV-1-DIV-5-DIV-2.txt set filetype=css
  augroup END
endif

" }}}

" Plugin Configuration {{{

" Disable netrw, since I'm using Dirvish instead.
let g:loaded_netrwPlugin = 1

" Configure note director.
let g:naivenote#dir = '~/Documents/Notes'

" Configure note mappings.
nnoremap <leader>n :call naivenote#create()<CR>
nnoremap <leader>j :call naivenote#journal()<CR>
nnoremap <leader>o :call naivenote#list()<CR>

" Add back mapping for undotree.
nnoremap <F5> :UndotreeToggle<CR>

" Enable syntax highlighting for JSDoc.
let g:javascript_plugin_jsdoc = 1

" }}}

" Colorscheme {{{

set background=light

if has('termguicolors')
  set termguicolors
endif

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.light': {
  \       'override' : {
  \         'color00' : ['#FFFFFF', '255'],
  \       }
  \     }
  \   }
  \ }

silent! colorscheme PaperColor

" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2
