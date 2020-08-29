scriptencoding utf-8

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

" Make the jump-list behave like the tag list or a web browser.
if has('nvim-0.5')
  set jumpoptions=stack
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
noremap <silent><leader>d :edit /Volumes/Backups/tasks/todo.txt<CR>

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

if executable('/usr/local/bin/bash')
  set shell=/usr/local/bin/bash
endif

if executable('/usr/local/bin/fish')
  set shell=/usr/local/bin/fish
endif

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
  nmap <silent> <leader>t <Plug>(PrimaryTerminalOpen)
  nmap <silent> <leader>r <Plug>(PrimaryTerminalOpenSplit)
  nmap <silent> <leader>y <Plug>(PrimaryTerminalOpenVsplit)
endif

" }}}

" Plugin Configuration {{{

" Disable netrw, since I'm using Dirvish instead.
let g:loaded_netrwPlugin = 1

" Configure note director.
let g:naivenote#dir = '/Volumes/Backups/Notes'

" Configure note mappings.
nnoremap <leader>n :call naivenote#create()<CR>
nnoremap <leader>j :call naivenote#journal()<CR>
nnoremap <leader>o :call naivenote#list()<CR>

" Add mapping for undotree.
nnoremap <F5> :UndotreeToggle<CR>

" Enable syntax highlighting for JSDoc.
let g:javascript_plugin_jsdoc = 1

function! PageClose(page_alternate_bufnr)
  bdelete!
  if bufnr('%') == a:page_alternate_bufnr && mode('%') ==# 'n'
    normal! a
  endif
endfunction
augroup pager
  autocmd!
  autocmd User PageOpen :nnoremap <buffer> gq :call PageClose(b:page_alternate_bufnr)<CR>
augroup END

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
