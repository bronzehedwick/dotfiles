scriptencoding utf-8

" Re-mappings {{{

" Remap mapleader.
" let mapleader = ','

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

" Message pager does not fill entire screen.
" See https://github.com/neovim/neovim/pull/8088
set fillchars+=msgsep:◌

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
  set grepprg=rg\ --no-heading\ --vimgrep
endif

if executable('urlview')
  function! UrlView() abort
    :startinsert
    :silent write! /tmp/nvim-extract-url.out
    :split term://urlview /tmp/nvim-extract-url.out
  endfunction
  nnoremap <leader>u :call UrlView()<CR>
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

" Make list-like commands more intuitive.
function! CCR()
  let cmdline = getcmdline()
  if cmdline =~ '\v\C^(ls|files|buffers)'
    " Like :ls but prompts for a buffer command.
    return "\<CR>:b"
  elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
    " Like :g//# but prompts for a command.
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    " Like :dlist or :ilist but prompts for a count for :djump or :ijump.
    return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    " Like :clist or :llist but prompts for an error/location number.
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    " Like :oldfiles but prompts for an old file to edit.
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    " Like :changes but prompts for a change to jump to.
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    " Like :jumps but prompts for a position to jump to.
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    " Like :marks but prompts for a mark to jump to.
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    " Like :undolist but prompts for a change to undo.
    return "\<CR>:u "
  else
    return "\<CR>"
  endif
endfunction
cnoremap <expr> <CR> CCR()

" }}}

" Display {{{

" Don't redraw while typing macros.
set lazyredraw

" Update swap file and gitgutter much faster.
set updatetime=250

" Command <Tab> completion.
set wildmode=longest:full

" Message popup is slightly transparent.
set pumblend=10

" Highlight invisible whitespace.
set list

" Set hard wrapping guide.
set colorcolumn=80

" Diff options.
set diffopt=internal,filler,vertical,algorithm:patience

" Show effects of commands incrementally, as you type.
set inccommand=nosplit

" Make file messages even shorter and messier.
set shortmess=filnxrtToOF

" Turn off search highlight after cursor moved.
noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

function! HlSearch()
  let s:pos = match(getline('.'), @/, col('.') - 1) + 1
  if s:pos != col('.')
    call StopHL()
  endif
endfunction

function! StopHL()
  if !v:hlsearch || mode() isnot 'n'
    return
  else
    sil call feedkeys("\<Plug>(StopHL)", 'm')
  endif
endfunction

augroup SearchHighlight
  au!
  au CursorMoved * call HlSearch()
  au InsertEnter * call StopHL()
augroup end

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

" Strip trailing whitespace.
nnoremap <silent> <M-s> :%s/\s\+$//e<CR>

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
nnoremap <leader>f :call naivenote#search()<CR>

" Add mapping for undotree.
nnoremap <F8> :UndotreeToggle<CR>

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

let g:xcodelight_green_comments = 1
let g:xcodedarkhc_green_comments = 1

if executable('dark-mode')
  let s:darkmode = substitute(system('dark-mode status'), '\n\+$', '', '')
  if s:darkmode ==# 'on'
    set background=dark
    silent! colorscheme xcodedarkhc
  else
    silent! colorscheme xcodelight
  endif
else
  silent! colorscheme xcodelight
endif

" }}}

" vim:fdm=marker ft=vim et sts=2 sw=2
