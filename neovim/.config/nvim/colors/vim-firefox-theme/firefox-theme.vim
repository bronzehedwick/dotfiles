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

hi clear
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
    hi Normal guifg=#8fa1b2 guibg=#14171a guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=fg guibg=#002b36 guisp=NONE gui=NONE cterm=NONE " in progress
    hi ToolbarButton guifg=#8fa1b2 guibg=#343c45 guisp=NONE gui=bold cterm=bold " in progress
    hi ToolbarLine guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi LineNr guifg=#657b83 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi NonText guifg=#657b83 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi SpecialKey guifg=#657b83 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hi Title guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi ColorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi Conceal guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Directory guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
    hi IncSearch guifg=#cb4b16 guibg=NONE guisp=NONE gui=standout cterm=standout " in progress
    hi MatchParen guifg=#fdf6e3 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hi WildMenu guifg=#eee8d5 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hi Pmenu guifg=#93a1a1 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuSbar guifg=NONE guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuSel guifg=#eee8d5 guibg=#657b83 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuThumb guifg=NONE guibg=#839496 guisp=NONE gui=NONE cterm=NONE " in progress
    hi Question guifg=#2aa198 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi Search guifg=#b58900 guibg=NONE guisp=NONE gui=reverse cterm=reverse " in progress
    hi SignColumn guifg=#839496 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Visual guifg=#1d4f73 guibg=#f5f7fa guisp=NONE gui=reverse cterm=reverse
    hi VisualNOS guifg=NONE guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress

    hi ModeMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi MoreMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi NormalMode guifg=#839496 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi InsertMode guifg=#2aa198 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi VisualMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi CommandMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress

    hi Cursor guifg=#fdf6e3 guibg=#268bd2 guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorLine guifg=NONE guibg=#353b48 guisp=NONE gui=NONE cterm=NONE
    hi CursorLineNr guifg=#839496 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress

    hi FoldColumn guifg=#839496 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold " in progress

    hi Error guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=bold,reverse cterm=bold,reverse " in progress
    hi ErrorMsg guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi WarningMsg guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress

    hi SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=undercurl " in progress
    hi SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl " in progress
    hi SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl " in progress

    hi DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE " in progress
    hi DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE " in progress
    hi DiffDelete guifg=#dc322f guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hi DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE " in progress

    hi StatusLine guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hi StatusLineNC guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hi TabLine guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hi TabLineFill guifg=#343c45 guibg=#8fa1b2 guisp=NONE gui=reverse cterm=reverse
    hi TabLineSel guifg=#667380 guibg=#f7f7f7 guisp=NONE gui=reverse cterm=reverse
    hi VertSplit guifg=#073642 guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    " }}}
    " Syntax {{{2
    hi Comment guifg=#5c6773 guibg=NONE guisp=NONE gui=italic cterm=italic
    hi SpecialComment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic " in progress

    hi Constant guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi String guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Character guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Number guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Boolean guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Float guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Identifier guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Function guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Statement guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Conditional guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Repeat guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Label guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Operator guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Exception guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi PreProc guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Include guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Define guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Macro guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi PreCondit guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Type guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi StorageClass guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Structure guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Typedef guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Special guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi SpecialChar guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi SpecialKey guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Tag guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Delimiter guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress

    hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE " in progress
    hi Todo guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi Directory guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress

    hi Underlined guifg=#6c71c4 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
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
    hi Normal guifg=#18191a guibg=#fcfcfc guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=fg guibg=#002b36 guisp=NONE gui=NONE cterm=NONE " in progress
    hi ToolbarButton guifg=#18191a guibg=#ebeced guisp=NONE gui=bold cterm=bold " in progress
    hi ToolbarLine guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi LineNr guifg=#657b83 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi NonText guifg=#657b83 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi SpecialKey guifg=#657b83 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hi Title guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi ColorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi Conceal guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Directory guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi EndOfBuffer guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE " in progress
    hi IncSearch guifg=#cb4b16 guibg=NONE guisp=NONE gui=standout cterm=standout " in progress
    hi MatchParen guifg=#fdf6e3 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress
    hi WildMenu guifg=#eee8d5 guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress
    hi Pmenu guifg=#93a1a1 guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuSbar guifg=NONE guibg=#586e75 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuSel guifg=#eee8d5 guibg=#657b83 guisp=NONE gui=NONE cterm=NONE " in progress
    hi PmenuThumb guifg=NONE guibg=#839496 guisp=NONE gui=NONE cterm=NONE " in progress
    hi Question guifg=#2aa198 guibg=NONE guisp=NONE gui=bold cterm=bold " in progress
    hi Search guifg=#b58900 guibg=NONE guisp=NONE gui=reverse cterm=reverse " in progress
    hi SignColumn guifg=#839496 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi Visual guifg=#4c9ed9 guibg=#f5f7fa guisp=NONE gui=reverse cterm=reverse
    hi VisualNOS guifg=NONE guibg=#073642 guisp=NONE gui=reverse cterm=reverse " in progress

    hi ModeMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi MoreMsg guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE " in progress
    hi NormalMode guifg=#839496 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi InsertMode guifg=#2aa198 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi VisualMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress
    hi CommandMode guifg=#d33682 guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse " in progress

    hi Cursor guifg=#fdf6e3 guibg=#268bd2 guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorColumn guifg=NONE guibg=#073642 guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorLine guifg=NONE guibg=#f0f9fe guisp=NONE gui=NONE cterm=NONE " in progress
    hi CursorLineNr guifg=#839496 guibg=#073642 guisp=NONE gui=bold cterm=bold " in progress

    hi FoldColumn guifg=#839496 guibg=#073642 guisp=NONE gui=NONE cterm=NONE
    hi Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold

    hi Error guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=bold,reverse cterm=bold,reverse
    hi ErrorMsg guifg=#dc322f guibg=#fdf6e3 guisp=NONE gui=reverse cterm=reverse
    hi WarningMsg guifg=#cb4b16 guibg=NONE guisp=NONE gui=bold cterm=bold

    hi SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=undercurl
    hi SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl
    hi SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl

    hi DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE
    hi DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE
    hi DiffDelete guifg=#dc322f guibg=#073642 guisp=NONE gui=bold cterm=bold
    hi DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE

    hi StatusLine guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hi StatusLineNC guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hi TabLine guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hi TabLineFill guifg=#586e75 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hi TabLineSel guifg=#839496 guibg=#073642 guisp=NONE gui=reverse cterm=reverse
    hi VertSplit guifg=#073642 guibg=#586e75 guisp=NONE gui=NONE cterm=NONE"
    " }}}
    " Syntax {{{2
    hi Comment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic
    hi SpecialComment guifg=#586e75 guibg=NONE guisp=NONE gui=italic cterm=italic

    hi Constant guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi String guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Character guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Number guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Boolean guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Float guifg=#2aa198 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Identifier guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Function guifg=#268bd2 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Statement guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Conditional guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Repeat guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Label guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Operator guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Exception guifg=#859900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi PreProc guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Include guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Define guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Macro guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi PreCondit guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Type guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi StorageClass guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Structure guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Typedef guifg=#b58900 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Special guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialChar guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi SpecialKey guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Tag guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Delimiter guifg=#cb4b16 guibg=NONE guisp=NONE gui=NONE cterm=NONE

    hi Ignore guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Todo guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold
    hi Directory guifg=#d33682 guibg=NONE guisp=NONE gui=bold cterm=bold

    hi Underlined guifg=#6c71c4 guibg=NONE guisp=NONE gui=NONE cterm=NONE
    " }}}
  endif " }}}
endif

" vim:fdm=marker ft=vim et sts=2 sw=2
