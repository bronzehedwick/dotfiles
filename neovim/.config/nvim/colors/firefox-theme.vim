" Name: Firefox Theme
" Theme: firefox
" Description: Colorscheme based on Firefox's devtools theme
" Author: Chris DeLuca
" Maintainer: Chris DeLuca <code@chrisdeluca.me>
" Website: https://www.chrisdeluca.me
" License: OSI approved MIT license
" Last Updated: 2020-07-02T16:05:03

" References:
" - https://github.com/freeo/vim-kalisi/blob/master/colors/kalisi.vim
" - https://github.com/lifepillar/vim-solarized8/blob/master/colors/solarized8.vim
" - https://github.com/lifepillar/vim-colortemplate/blob/master/templates/dark_and_light.colortemplate
" - https://github.com/lifepillar/vim-wwdc17-theme/blob/master/colors/wwdc17.vim
" - https://github.com/NLKNguyen/papercolor-theme/blob/master/colors/PaperColor.vim

highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'firefox'

" Pallet {{{1
if &background ==# 'dark'
" Dark theme {{{2
let s:toolbar = '#343c45'
let s:toolbar_background = '#343c45'
let s:selection_background = '#1d4f73'
let s:selection_color = '#f5f7fa'
let s:splitter_color = '#000000'
let s:comment = '#5c6773'
let s:body_background = '#14171a'
let s:sidebar_background = '#181d20'
let s:contrast_background = '#b28025'
let s:body_color = '#8fa1b2'
let s:body_color_alt = '#b6babf'
let s:content_color1 = '#a9bacb'
let s:content_color2 = '#8fa1b2'
let s:content_color3 = '#667380'
let s:highlight_blue = '#46afe3'
let s:highlight_purple = '#6b7abb'
let s:highlight_pink = '#df80ff'
let s:highlight_red = '#eb5368'
let s:highlight_orange = '#d96629'
let s:highlight_lightorange = '#d99b28'
let s:highlight_green = '#70bf53'
let s:highlight_bluegrey = '#5e88b0'
let s:highlight_yellow = '#ffffb4'
" }}}
else
" Light {{{2
let s:toolbar = '#ebeced'
let s:toolbar_background = '#f0f1f2'
let s:selection_background = '#4c9ed9'
let s:selection_color = '#f5f7fa'
let s:splitter_color = '#aaaaaa'
let s:comment = '#747573'
let s:body_background = '#fcfcfc'
let s:sidebar_background = '#f7f7f7'
let s:contrast_background = '#e6b064'
let s:body_color = '#18191a'
let s:body_color_alt = '#585959'
let s:content_color1 = '#292e33'
let s:content_color2 = '#8fa1b2'
let s:content_color3 = '#667380'
let s:highlight_blue = '#0088cc'
let s:highlight_purple = '#5b5fff'
let s:highlight_pink = '#b82ee5'
let s:highlight_red = '#ed2655'
let s:highlight_orange = '#f13c00'
let s:highlight_lightorange = '#d97e00'
let s:highlight_green = '#2cbb0f'
let s:highlight_bluegrey = '#0072ab'
let s:highlight_yellow = '#ffffb4'
endif
" }}}
" }}}

" Colors
if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Terminal {{{1
  " Vim8 Terminal colors {{{2
  let g:terminal_ansi_colors = ['#5f5f61', '#e8503f', '#00998c', '#d87900',
        \ '#527f8f', '#db2d45', '#159ccc', '#f0f0f0', '#888888', '#d87900',
        \ '#abb96e', '#e1ad0b', '#8c61a6', '#eb314b', '#23bce1', '#fafafa']
  " }}}
  " Neovim Terminal colors {{{2
  if has('nvim')
    let g:terminal_color_0 = '#5f5f61'
    let g:terminal_color_1 = '#e8503f'
    let g:terminal_color_2 = '#00998c'
    let g:terminal_color_3 = '#d87900'
    let g:terminal_color_4 = '#527f8f'
    let g:terminal_color_5 = '#db2d45'
    let g:terminal_color_6 = '#159ccc'
    let g:terminal_color_7 = '#f0f0f0'
    let g:terminal_color_8 = '#888888'
    let g:terminal_color_9 = '#d87900'
    let g:terminal_color_10 = '#abb96e'
    let g:terminal_color_11 = '#e1ad0b'
    let g:terminal_color_12 = '#8c61a6'
    let g:terminal_color_13 = '#eb314b'
    let g:terminal_color_14 = '#23bce1'
    let g:terminal_color_15 = '#fafafa'
  endif " }}}
  " }}}
  " User interface {{{1
  exec "highlight Normal guisp=NONE gui=NONE cterm=NONE guifg=" . s:body_color . " guibg=" . s:body_background
  highlight Terminal guifg=fg guibg=#002b36 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight ToolbarButton guifg=#18191a guibg=#ebeced guisp=NONE gui=bold cterm=bold " in progress
  highlight ToolbarLine guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight LineNr guifg=#657b83 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight NonText guifg=#657b83 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
  highlight SpecialKey guifg=#657b83 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
  highlight Title guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
  highlight ColorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight Conceal guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
  highlight Directory guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
  highlight EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE " in progress
  highlight IncSearch guifg=#cb4b16 guibg=NONE guisp=NONE gui=standout cterm=standout " in progress
  highlight MatchParen guifg=#fdf6e3 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
  highlight WildMenu guifg=#eee8d5 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
  highlight Pmenu guifg=#93a1a1 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight PmenuSbar guifg=NONE guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight PmenuSel guifg=#eee8d5 guibg=#657b83 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight PmenuThumb guifg=NONE guibg=#839496 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight Question guifg=#2aa198 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
  highlight Search guifg=#b58900 guibg=NONE guisp=NONE gui=reverse cterm=reverse " in progress
  highlight SignColumn guifg=#839496 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
  highlight Visual guifg=#4c9ed9 guibg=#f5f7fa guisp=NONE gui=reverse cterm=reverse
  highlight VisualNOS guifg=NONE guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress

  highlight ModeMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
  highlight MoreMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
  highlight NormalMode guifg=#839496 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
  highlight InsertMode guifg=#2aa198 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
  highlight ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
  highlight VisualMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
  highlight CommandMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress

  exec "highlight Cursor guifg=" . s:content_color3 . " guibg=" . s:content_color1 . " guisp=NONE gui=NONE cterm=NONE"
  highlight CursorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
  highlight CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE " in progress
  highlight CursorLine guifg=NONE guibg=#f0f9fe guisp=NONE gui=NONE cterm=NONE " in progress
  highlight CursorLineNr guifg=#839496 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress

  highlight FoldColumn guifg=#839496 guibg=#073642 guisp=NONE gui=NONE cterm=NONE
  highlight Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold

  highlight Error guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=bold,reverse cterm=bold,reverse
  highlight ErrorMsg guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse
  highlight WarningMsg guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold

  highlight SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=undercurl
  highlight SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl
  highlight SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl

  highlight DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE
  highlight DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE
  highlight DiffDelete guifg=#dc322f guibg=#073642 guisp=NONE gui=bold cterm=bold
  highlight DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE

  highlight StatusLine guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
  highlight StatusLineNC guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
  highlight TabLine guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
  highlight TabLineFill guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
  highlight TabLineSel guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
  highlight VertSplit guifg=#073642 guibg=#586e75 guisp=NONE gui=NONE cterm=NONE"
  " }}}
  " Syntax {{{1
  highlight Comment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic
  highlight SpecialComment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic

  highlight Constant guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight String guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Character guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Number guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Boolean guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Float guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Identifier guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Function guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Statement guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Conditional guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Repeat guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Label guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Operator guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Exception guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight PreProc guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Include guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Define guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Macro guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight PreCondit guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Type guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight StorageClass guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Structure guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Typedef guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Special guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight SpecialChar guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight SpecialKey guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Tag guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  highlight Delimiter guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

  highlight Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  highlight Todo guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold
  highlight Directory guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold

  highlight Underlined guifg=#6c71c4 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  " }}}
endif

" vim:fdm=marker ft=vim et sts=2 sw=2
