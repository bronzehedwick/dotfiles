set nocompatible	" vi is old; bring in the vim hottness
set background=dark	" Defaults for a dark colorscheme
set wildmenu		" Nice tab searching 
syntax on		" Syntax highlighting
set ruler		" Show info about the file
set incsearch		" Search while you type
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd                 " Show partial commands in status line and
set showmode                    " Display the current mode
set showmatch                   " Show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set shiftwidth=2 " 2 space soft tabs
set tabstop=2 " 2 space tabs
set expandtab " Soft tabs
set relativenumber " Relative line numbers
set hlsearch " Highlighted search

let mapleader = ',' " Reassign map leader to ','

" From vim sensible
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set laststatus=2
set showcmd
set incsearch

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

" Check if a colorscheme exists
function! HasColorscheme(name)
  let pat = 'colors/'.a:name.'.vim'
  return !empty(globpath(&rtp, pat))
endfunction

" Set colorscheme
if HasColorscheme('ir_black')
  colorscheme ir_black
else
  colorscheme desert
endif
