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

hightlight clear
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

if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Dark theme {{{1
  if &background ==# 'dark'
    " Terminal {{{2
    " Vim8 Terminal colors {{{3
    let g:terminal_ansi_colors = ['#5f5f61', '#e8503f', '#00998c', '#d87900',
          \ '#527f8f', '#db2d45', '#159ccc', '#f0f0f0', '#888888', '#d87900',
          \ '#abb96e', '#e1ad0b', '#8c61a6', '#eb314b', '#23bce1', '#fafafa']
    " }}}
    " Neovim Terminal colors {{{3
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
      " }}}
    endif " }}}
    " User interface {{{2
    hightlight Normal guifg=#8fa1b2 guibg=#14171a guisp=NONE gui=NONE cterm=NONE
    hightlight Terminal guifg=fg guibg=#002b36 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight ToolbarButton guifg=#8fa1b2 guibg=#343c45 guisp=NONE gui=bold cterm=bold " in progress
    hightlight ToolbarLine guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight LineNr guifg=#657b83 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight NonText guifg=#657b83 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight SpecialKey guifg=#657b83 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hightlight Title guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight ColorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Conceal guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Directory guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
    hightlight IncSearch guifg=#cb4b16 guibg=NONE guisp=NONE gui=standout cterm=standout " in progress
    hightlight MatchParen guifg=#fdf6e3 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hightlight WildMenu guifg=#eee8d5 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight Pmenu guifg=#93a1a1 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuSbar guifg=NONE guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuSel guifg=#eee8d5 guibg=#657b83 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuThumb guifg=NONE guibg=#839496 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Question guifg=#2aa198 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight Search guifg=#b58900 guibg=NONE guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight SignColumn guifg=#839496 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Visual guifg=#1d4f73 guibg=#f5f7fa guisp=NONE gui=reverse cterm=reverse
    hightlight VisualNOS guifg=NONE guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress

    hightlight ModeMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight MoreMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight NormalMode guifg=#839496 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight InsertMode guifg=#2aa198 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight VisualMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight CommandMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress

    hightlight Cursor guifg=#fdf6e3 guibg=#268bd2 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorLine guifg=NONE guibg=#353b48 guisp=NONE gui=NONE cterm=NONE
    hightlight CursorLineNr guifg=#839496 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress

    hightlight FoldColumn guifg=#839496 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold " in progress

    hightlight Error guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=bold,reverse cterm=bold,reverse " in progress
    hightlight ErrorMsg guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight WarningMsg guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress

    hightlight SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=undercurl " in progress
    hightlight SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl " in progress
    hightlight SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl " in progress

    hightlight DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE " in progress
    hightlight DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE " in progress
    hightlight DiffDelete guifg=#dc322f guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hightlight DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE " in progress

    hightlight StatusLine guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hightlight StatusLineNC guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight TabLine guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hightlight TabLineFill guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hightlight TabLineSel guifg=#667380 guibg=#f7f7f7 guisp=NONE gui=reverse cterm=reverse
    hightlight VertSplit guifg=#073642 guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    " }}}
    " Syntax {{{2
    hightlight Comment guifg=#5c6773 guibg=NONE guisp=NONE gui=italic cterm=italic
    hightlight SpecialComment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic " in progress

    hightlight Constant guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight String guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Character guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Number guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Boolean guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Float guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Identifier guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Function guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Statement guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Conditional guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Repeat guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Label guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Operator guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Exception guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight PreProc guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Include guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Define guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Macro guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PreCondit guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Type guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight StorageClass guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Structure guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Typedef guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Special guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight SpecialChar guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight SpecialKey guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Tag guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Delimiter guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hightlight Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE " in progress
    hightlight Todo guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight Directory guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress

    hightlight Underlined guifg=#6c71c4 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    " }}}
  else " }}}
    " Light theme {{{1
    " Terminal {{{2
    " Vim8 Terminal colors {{{3
    let g:terminal_ansi_colors = ['#5f5f61', '#e8503f', '#00998c', '#d87900',
          \ '#527f8f', '#db2d45', '#159ccc', '#f0f0f0', '#888888', '#d87900',
          \ '#abb96e', '#e1ad0b', '#8c61a6', '#eb314b', '#23bce1', '#fafafa']
    " }}}
    " Neovim Terminal colors {{{3
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
    " User interface {{{2
    exec "hightlight Normal guisp=NONE gui=NONE cterm=NONE guifg=" . s:body_color . " guibg=" . s:body_background
    hightlight Terminal guifg=fg guibg=#002b36 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight ToolbarButton guifg=#18191a guibg=#ebeced guisp=NONE gui=bold cterm=bold " in progress
    hightlight ToolbarLine guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight LineNr guifg=#657b83 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight NonText guifg=#657b83 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight SpecialKey guifg=#657b83 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hightlight Title guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight ColorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Conceal guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Directory guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE " in progress
    hightlight IncSearch guifg=#cb4b16 guibg=NONE guisp=NONE gui=standout cterm=standout " in progress
    hightlight MatchParen guifg=#fdf6e3 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hightlight WildMenu guifg=#eee8d5 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight Pmenu guifg=#93a1a1 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuSbar guifg=NONE guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuSel guifg=#eee8d5 guibg=#657b83 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight PmenuThumb guifg=NONE guibg=#839496 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Question guifg=#2aa198 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hightlight Search guifg=#b58900 guibg=NONE guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight SignColumn guifg=#839496 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight Visual guifg=#4c9ed9 guibg=#f5f7fa guisp=NONE gui=reverse cterm=reverse
    hightlight VisualNOS guifg=NONE guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress

    hightlight ModeMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight MoreMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight NormalMode guifg=#839496 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight InsertMode guifg=#2aa198 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight VisualMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hightlight CommandMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress

    hightlight Cursor guifg=#fdf6e3 guibg=#268bd2 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorLine guifg=NONE guibg=#f0f9fe guisp=NONE gui=NONE cterm=NONE " in progress
    hightlight CursorLineNr guifg=#839496 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress

    hightlight FoldColumn guifg=#839496 guibg=#073642 guisp=NONE gui=NONE cterm=NONE
    hightlight Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold

    hightlight Error guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hightlight ErrorMsg guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse
    hightlight WarningMsg guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold

    hightlight SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=undercurl
    hightlight SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl
    hightlight SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl

    hightlight DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE
    hightlight DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE
    hightlight DiffDelete guifg=#dc322f guibg=#073642 guisp=NONE gui=bold cterm=bold
    hightlight DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE

    hightlight StatusLine guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hightlight StatusLineNC guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hightlight TabLine guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hightlight TabLineFill guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hightlight TabLineSel guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hightlight VertSplit guifg=#073642 guibg=#586e75 guisp=NONE gui=NONE cterm=NONE"
    " }}}
    " Syntax {{{2
    hightlight Comment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic
    hightlight SpecialComment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic

    hightlight Constant guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight String guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Character guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Number guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Boolean guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Float guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Identifier guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Function guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Statement guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Conditional guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Repeat guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Label guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Operator guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Exception guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight PreProc guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Include guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Define guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Macro guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight PreCondit guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Type guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight StorageClass guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Structure guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Typedef guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Special guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight SpecialChar guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight SpecialKey guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Tag guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hightlight Delimiter guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hightlight Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
    hightlight Todo guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold
    hightlight Directory guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold

    hightlight Underlined guifg=#6c71c4 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    " }}}
  endif " }}}
endif

" vim:fdm=marker ft=vim et sts=2 sw=2
