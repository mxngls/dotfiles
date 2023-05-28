hi clear
let g:colors_name = 'solarized_custom'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 1

hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Debug Special
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link QuickFixLine Search
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor

if &background ==# 'dark'
  if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = ['#073642', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5', '#002b36', '#cb4b16', '#586e75', '#657b83', '#839496', '#6c71c4', '#93a1a1', '#fdf6e3']
  endif
  if has('nvim')
    let g:terminal_color_0 = '#073642'
    let g:terminal_color_1 = '#dc322f'
    let g:terminal_color_2 = '#859900'
    let g:terminal_color_3 = '#b58900'
    let g:terminal_color_4 = '#268bd2'
    let g:terminal_color_5 = '#d33682'
    let g:terminal_color_6 = '#2aa198'
    let g:terminal_color_7 = '#eee8d5'
    let g:terminal_color_8 = '#002b36'
    let g:terminal_color_9 = '#cb4b16'
    let g:terminal_color_10 = '#586e75'
    let g:terminal_color_11 = '#657b83'
    let g:terminal_color_12 = '#839496'
    let g:terminal_color_13 = '#6c71c4'
    let g:terminal_color_14 = '#93a1a1'
    let g:terminal_color_15 = '#fdf6e3'
  endif
  hi Normal guifg=#93a1a1 guibg=#002b36 gui=NONE cterm=NONE
  hi FoldColumn guifg=#839496 guibg=#073642 gui=NONE cterm=NONE
  hi Folded guifg=#839496 guibg=#073642 guisp=#002b36 gui=bold cterm=bold
  hi Terminal guifg=fg guibg=#002b36 gui=NONE cterm=NONE
  hi ToolbarButton guifg=#93a1a1 guibg=#073642 gui=bold cterm=bold
  hi ToolbarLine guifg=NONE guibg=#073642 gui=NONE cterm=NONE
  hi Cursor guifg=#fdf6e3 guibg=#268bd2 gui=NONE cterm=NONE
  hi CursorLineNr guifg=#839496 guibg=#073642 gui=bold cterm=bold
  hi LineNr guifg=#657b83 guibg=#073642 gui=NONE cterm=NONE
  hi NonText guifg=#657b83 guibg=NONE gui=bold cterm=bold
  hi SpecialKey guifg=#657b83 guibg=#073642 gui=bold cterm=bold
  hi SpellBad guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=underline
  hi SpellCap guifg=#6c71c4 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=underline
  hi SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=underline
  hi SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=underline
  hi Title guifg=#cb4b16 guibg=NONE gui=bold cterm=bold
  hi Cursor guifg=#fdf6e3 guibg=#268bd2 gui=NONE cterm=NONE
  hi DiffAdd guifg=#859900 guibg=NONE guisp=#859900 gui=NONE cterm=NONE
  hi DiffChange guifg=#b58900 guibg=NONE guisp=#b58900 gui=NONE cterm=NONE
  hi DiffDelete guifg=#dc322f guibg=NONE gui=bold cterm=bold
  hi DiffText guifg=#268bd2 guibg=NONE guisp=#268bd2 gui=NONE cterm=NONE
  hi DiffAdd guifg=#859900 guibg=#073642 guisp=#859900 gui=NONE cterm=NONE
  hi DiffChange guifg=#b58900 guibg=#073642 guisp=#b58900 gui=NONE cterm=NONE
  hi DiffDelete guifg=#dc322f guibg=#073642 gui=bold cterm=bold
  hi DiffText guifg=#268bd2 guibg=#073642 guisp=#268bd2 gui=NONE cterm=NONE
  hi StatusLine guifg=#839496 guibg=#073642 gui=reverse cterm=reverse
  hi StatusLineNC guifg=#586e75 guibg=#073642 gui=reverse cterm=reverse
  hi TabLine guifg=#586e75 guibg=#073642 gui=reverse cterm=reverse
  hi TabLineFill guifg=#586e75 guibg=#073642 gui=reverse cterm=reverse
  hi TabLineSel guifg=#839496 guibg=#073642 gui=reverse cterm=reverse
  hi VertSplit guifg=#073642 guibg=#586e75 gui=NONE cterm=NONE
  hi ColorColumn guifg=NONE guibg=#073642 gui=NONE cterm=NONE
  hi Conceal guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi CursorColumn guifg=NONE guibg=#073642 gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#073642 gui=NONE cterm=NONE
  hi Directory guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi EndOfBuffer guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg guifg=#dc322f guibg=#fdf6e3 gui=reverse cterm=reverse
  hi IncSearch guifg=#cb4b16 guibg=NONE gui=standout cterm=standout
  hi MatchParen guifg=#fdf6e3 guibg=#073642 gui=bold cterm=bold
  hi ModeMsg guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi MoreMsg guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi Pmenu guifg=#93a1a1 guibg=#073642 gui=NONE cterm=NONE
  hi PmenuSbar guifg=NONE guibg=#586e75 gui=NONE cterm=NONE
  hi PmenuSel guifg=#eee8d5 guibg=#657b83 gui=NONE cterm=NONE
  hi PmenuThumb guifg=NONE guibg=#839496 gui=NONE cterm=NONE
  hi Question guifg=#2aa198 guibg=NONE gui=bold cterm=bold
  hi Search guifg=#b58900 guibg=NONE gui=reverse cterm=reverse
  hi SignColumn guifg=#839496 guibg=NONE gui=NONE cterm=NONE
  hi Visual guifg=#586e75 guibg=#002b36 gui=reverse cterm=reverse
  hi VisualNOS guifg=NONE guibg=#073642 gui=reverse cterm=reverse
  hi WarningMsg guifg=#cb4b16 guibg=NONE gui=bold cterm=bold
  hi WildMenu guifg=#eee8d5 guibg=#073642 gui=reverse cterm=reverse
  hi Comment guifg=#586e75 guibg=NONE gui=italic cterm=italic
  hi Constant guifg=#2aa198 guibg=NONE gui=NONE cterm=NONE
  hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
  hi Error guifg=#dc322f guibg=#fdf6e3 gui=bold,reverse cterm=bold,reverse
  hi Identifier guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc guifg=#cb4b16 guibg=NONE gui=NONE cterm=NONE
  hi Special guifg=#cb4b16 guibg=NONE gui=NONE cterm=NONE
  hi Statement guifg=#859900 guibg=NONE gui=NONE cterm=NONE
  hi Todo guifg=#d33682 guibg=NONE gui=bold cterm=bold
  hi Type guifg=#b58900 guibg=NONE gui=NONE cterm=NONE
  hi Underlined guifg=#6c71c4 guibg=NONE gui=NONE cterm=NONE
  hi NormalMode guifg=#839496 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi InsertMode guifg=#2aa198 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi VisualMode guifg=#d33682 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi CommandMode guifg=#d33682 guibg=#fdf6e3 gui=reverse cterm=reverse
else
  " Light background
  if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = ['#073642', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5', '#002b36', '#cb4b16', '#586e75', '#657b83', '#839496', '#6c71c4', '#93a1a1', '#fdf6e3']
  endif
  if has('nvim')
    let g:terminal_color_0 = '#073642'
    let g:terminal_color_1 = '#dc322f'
    let g:terminal_color_2 = '#859900'
    let g:terminal_color_3 = '#b58900'
    let g:terminal_color_4 = '#268bd2'
    let g:terminal_color_5 = '#d33682'
    let g:terminal_color_6 = '#2aa198'
    let g:terminal_color_7 = '#eee8d5'
    let g:terminal_color_8 = '#002b36'
    let g:terminal_color_9 = '#cb4b16'
    let g:terminal_color_10 = '#586e75'
    let g:terminal_color_11 = '#657b83'
    let g:terminal_color_12 = '#839496'
    let g:terminal_color_13 = '#6c71c4'
    let g:terminal_color_14 = '#93a1a1'
    let g:terminal_color_15 = '#fdf6e3'
  endif
  hi Normal guifg=#586e75 guibg=#fdf6e3 gui=NONE cterm=NONE
  hi FoldColumn guifg=#657b83 guibg=#eee8d5 gui=NONE cterm=NONE
  hi Folded guifg=#657b83 guibg=#eee8d5 guisp=#fdf6e3 gui=bold cterm=bold
  hi Terminal guifg=fg guibg=#fdf6e3 gui=NONE cterm=NONE
  hi ToolbarButton guifg=#586e75 guibg=#eee8d5 gui=bold cterm=bold
  hi ToolbarLine guifg=NONE guibg=#eee8d5 gui=NONE cterm=NONE
  hi Cursor guifg=#fdf6e3 guibg=#cb4b16 gui=NONE cterm=NONE
  hi CursorLineNr guifg=#657b83 guibg=#eee8d5 gui=bold cterm=bold
  hi LineNr guifg=#839496 guibg=#eee8d5 gui=NONE cterm=NONE
  hi MatchParen guifg=#dc322f guibg=#eee8d5 gui=bold,underline cterm=bold,underline
  hi NonText guifg=#839496 guibg=NONE gui=bold cterm=bold
  hi SpecialKey guifg=#839496 guibg=#eee8d5 gui=bold cterm=bold
  hi SpellBad guifg=#d33682 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=underline
  hi SpellCap guifg=#d33682 guibg=NONE guisp=#6c71c4 gui=undercurl cterm=underline
  hi SpellLocal guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=underline
  hi SpellRare guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=underline
  hi Title guifg=#cb4b16 guibg=NONE gui=bold cterm=bold
  hi DiffAdd guifg=#859900 guibg=#eee8d5 guisp=#859900 gui=NONE cterm=NONE
  hi DiffChange guifg=#b58900 guibg=#eee8d5 guisp=#b58900 gui=NONE cterm=NONE
  hi DiffDelete guifg=#dc322f guibg=#eee8d5 gui=bold cterm=bold
  hi DiffText guifg=#268bd2 guibg=#eee8d5 guisp=#268bd2 gui=NONE cterm=NONE
  hi StatusLine guifg=#586e75 guibg=#eee8d5 gui=reverse cterm=reverse
  hi StatusLineNC guifg=#839496 guibg=#eee8d5 gui=reverse cterm=reverse
  hi TabLine guifg=#839496 guibg=#eee8d5 gui=reverse cterm=reverse
  hi TabLineFill guifg=#839496 guibg=#eee8d5 gui=reverse cterm=reverse
  hi TabLineSel guifg=#586e75 guibg=#eee8d5 gui=reverse cterm=reverse
  hi VertSplit guifg=#586e75 guibg=#93a1a1 gui=NONE cterm=NONE
  hi WildMenu guifg=#073642 guibg=#eee8d5 gui=reverse cterm=reverse
  hi ColorColumn guifg=NONE guibg=#eee8d5 gui=NONE cterm=NONE
  hi Conceal guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi CursorColumn guifg=NONE guibg=#eee8d5 gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#eee8d5 gui=NONE cterm=NONE
  hi Directory guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi EndOfBuffer guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg guifg=#dc322f guibg=#fdf6e3 gui=reverse cterm=reverse
  hi IncSearch guifg=#cb4b16 guibg=NONE gui=standout cterm=standout
  hi ModeMsg guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi MoreMsg guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi Pmenu guifg=#586e75 guibg=#eee8d5 gui=NONE cterm=NONE
  hi PmenuSbar guifg=NONE guibg=#93a1a1 gui=NONE cterm=NONE
  hi PmenuSel guifg=#eee8d5 guibg=#839496 gui=NONE cterm=NONE
  hi PmenuThumb guifg=NONE guibg=#657b83 gui=NONE cterm=NONE
  hi Question guifg=#2aa198 guibg=NONE gui=bold cterm=bold
  hi Search guifg=#b58900 guibg=NONE gui=reverse cterm=reverse
  hi SignColumn guifg=#657b83 guibg=NONE gui=NONE cterm=NONE
  hi Visual guifg=#93a1a1 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi VisualNOS guifg=NONE guibg=#eee8d5 gui=reverse cterm=reverse
  hi WarningMsg guifg=#cb4b16 guibg=NONE gui=bold cterm=bold
  hi Comment guifg=#93a1a1 guibg=NONE gui=italic cterm=italic
  hi Constant guifg=#2aa198 guibg=NONE gui=NONE cterm=NONE
  hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
  hi Error guifg=#dc322f guibg=#fdf6e3 gui=bold,reverse cterm=bold,reverse
  hi Identifier guifg=#268bd2 guibg=NONE gui=NONE cterm=NONE
  hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PreProc guifg=#cb4b16 guibg=NONE gui=NONE cterm=NONE
  hi Special guifg=#cb4b16 guibg=NONE gui=NONE cterm=NONE
  hi Statement guifg=#859900 guibg=NONE gui=NONE cterm=NONE
  hi Todo guifg=#d33682 guibg=NONE gui=bold cterm=bold
  hi Type guifg=#b58900 guibg=NONE gui=NONE cterm=NONE
  hi Underlined guifg=#6c71c4 guibg=NONE gui=NONE cterm=NONE
  hi NormalMode guifg=#586e75 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi InsertMode guifg=#2aa198 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi ReplaceMode guifg=#cb4b16 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi VisualMode guifg=#d33682 guibg=#fdf6e3 gui=reverse cterm=reverse
  hi CommandMode guifg=#d33682 guibg=#fdf6e3 gui=reverse cterm=reverse
  if has('nvim')
    hi! link TermCursor Cursor
    hi TermCursorNC guifg=#fdf6e3 guibg=#93a1a1 gui=NONE cterm=NONE
  endif
endif

if s:t_Co >= 256
  if &background ==# 'dark'
    hi Normal ctermfg=247 ctermbg=235 cterm=NONE
    hi FoldColumn ctermfg=246 ctermbg=236 cterm=NONE
    hi Folded ctermfg=246 ctermbg=236 cterm=bold
    hi Terminal ctermfg=fg ctermbg=235 cterm=NONE
    hi ToolbarButton ctermfg=247 ctermbg=236 cterm=bold
    hi ToolbarLine ctermfg=NONE ctermbg=236 cterm=NONE
    hi CursorLineNr ctermfg=246 ctermbg=236 cterm=bold
    hi LineNr ctermfg=66 ctermbg=236 cterm=NONE
    hi NonText ctermfg=66 ctermbg=NONE cterm=bold
    hi SpecialKey ctermfg=66 ctermbg=236 cterm=bold
    hi SpellBad ctermfg=61 ctermbg=NONE cterm=underline
    hi SpellCap ctermfg=61 ctermbg=NONE cterm=underline
    hi SpellLocal ctermfg=136 ctermbg=NONE cterm=underline
    hi SpellRare ctermfg=37 ctermbg=NONE cterm=underline
    hi Title ctermfg=166 ctermbg=NONE cterm=bold
    hi Cursor ctermfg=230 ctermbg=32 cterm=NONE
    hi DiffAdd ctermfg=106 ctermbg=236 cterm=NONE
    hi DiffChange ctermfg=136 ctermbg=236 cterm=NONE
    hi DiffDelete ctermfg=160 ctermbg=236 cterm=bold
    hi DiffText ctermfg=32 ctermbg=236 cterm=NONE
    hi StatusLine ctermfg=246 ctermbg=236 cterm=reverse
    hi StatusLineNC ctermfg=242 ctermbg=236 cterm=reverse
    hi TabLine ctermfg=242 ctermbg=236 cterm=reverse
    hi TabLineFill ctermfg=242 ctermbg=236 cterm=reverse
    hi TabLineSel ctermfg=246 ctermbg=236 cterm=reverse
    hi VertSplit ctermfg=236 ctermbg=242 cterm=NONE
    hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE
    hi Conceal ctermfg=32 ctermbg=NONE cterm=NONE
    hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
    hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
    hi Directory ctermfg=32 ctermbg=NONE cterm=NONE
    hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ErrorMsg ctermfg=160 ctermbg=230 cterm=reverse
    hi IncSearch ctermfg=166 ctermbg=NONE cterm=standout
    hi MatchParen ctermfg=230 ctermbg=236 cterm=bold
    hi ModeMsg ctermfg=32 ctermbg=NONE cterm=NONE
    hi MoreMsg ctermfg=32 ctermbg=NONE cterm=NONE
    hi Pmenu ctermfg=247 ctermbg=236 cterm=NONE
    hi PmenuSbar ctermfg=NONE ctermbg=242 cterm=NONE
    hi PmenuSel ctermfg=254 ctermbg=66 cterm=NONE
    hi PmenuThumb ctermfg=NONE ctermbg=246 cterm=NONE
    hi Question ctermfg=37 ctermbg=NONE cterm=bold
    hi Search ctermfg=136 ctermbg=NONE cterm=reverse
    hi SignColumn ctermfg=246 ctermbg=NONE cterm=NONE
    hi Visual ctermfg=242 ctermbg=235 cterm=reverse
    hi VisualNOS ctermfg=NONE ctermbg=236 cterm=reverse
    hi WarningMsg ctermfg=166 ctermbg=NONE cterm=bold
    hi WildMenu ctermfg=254 ctermbg=236 cterm=reverse
    hi Comment ctermfg=242 ctermbg=NONE cterm=italic
    hi Constant ctermfg=37 ctermbg=NONE cterm=NONE
    hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
    hi Error ctermfg=160 ctermbg=230 cterm=bold,reverse
    hi Identifier ctermfg=32 ctermbg=NONE cterm=NONE
    hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PreProc ctermfg=166 ctermbg=NONE cterm=NONE
    hi Special ctermfg=166 ctermbg=NONE cterm=NONE
    hi Statement ctermfg=106 ctermbg=NONE cterm=NONE
    hi Todo ctermfg=162 ctermbg=NONE cterm=bold
    hi Type ctermfg=136 ctermbg=NONE cterm=NONE
    hi Underlined ctermfg=61 ctermbg=NONE cterm=NONE
    hi NormalMode ctermfg=246 ctermbg=230 cterm=reverse
    hi InsertMode ctermfg=37 ctermbg=230 cterm=reverse
    hi ReplaceMode ctermfg=166 ctermbg=230 cterm=reverse
    hi VisualMode ctermfg=162 ctermbg=230 cterm=reverse
    hi CommandMode ctermfg=162 ctermbg=230 cterm=reverse
    if has('nvim')
      hi! link TermCursor Cursor
      hi TermCursorNC ctermfg=235 ctermbg=242 cterm=NONE
    endif
  else
    " Light background
    hi Normal ctermfg=242 ctermbg=230 cterm=NONE
    hi FoldColumn ctermfg=66 ctermbg=254 cterm=NONE
    hi Folded ctermfg=66 ctermbg=254 cterm=bold
    hi Terminal ctermfg=fg ctermbg=230 cterm=NONE
    hi ToolbarButton ctermfg=242 ctermbg=254 cterm=bold
    hi ToolbarLine ctermfg=NONE ctermbg=254 cterm=NONE
    hi Cursor ctermfg=230 ctermbg=166 cterm=NONE
    hi CursorLineNr ctermfg=66 ctermbg=254 cterm=bold
    hi LineNr ctermfg=246 ctermbg=254 cterm=NONE
    hi MatchParen ctermfg=160 ctermbg=254 cterm=bold,underline
    hi NonText ctermfg=246 ctermbg=NONE cterm=bold
    hi SpecialKey ctermfg=246 ctermbg=254 cterm=bold
    hi SpellBad ctermfg=162 ctermbg=NONE cterm=underline
    hi SpellCap ctermfg=162 ctermbg=NONE cterm=underline
    hi SpellLocal ctermfg=136 ctermbg=NONE cterm=underline
    hi SpellRare ctermfg=37 ctermbg=NONE cterm=underline
    hi Title ctermfg=166 ctermbg=NONE cterm=bold
    hi DiffAdd ctermfg=106 ctermbg=254 cterm=NONE
    hi DiffChange ctermfg=136 ctermbg=254 cterm=NONE
    hi DiffDelete ctermfg=160 ctermbg=254 cterm=bold
    hi DiffText ctermfg=32 ctermbg=254 cterm=NONE
    hi StatusLine ctermfg=242 ctermbg=254 cterm=reverse
    hi StatusLineNC ctermfg=246 ctermbg=254 cterm=reverse
    hi TabLine ctermfg=246 ctermbg=254 cterm=reverse
    hi TabLineFill ctermfg=246 ctermbg=254 cterm=reverse
    hi TabLineSel ctermfg=242 ctermbg=254 cterm=reverse
    hi VertSplit ctermfg=242 ctermbg=247 cterm=NONE
    hi WildMenu ctermfg=236 ctermbg=254 cterm=reverse
    hi ColorColumn ctermfg=NONE ctermbg=254 cterm=NONE
    hi Conceal ctermfg=32 ctermbg=NONE cterm=NONE
    hi CursorColumn ctermfg=NONE ctermbg=254 cterm=NONE
    hi CursorLine ctermfg=NONE ctermbg=254 cterm=NONE
    hi Directory ctermfg=32 ctermbg=NONE cterm=NONE
    hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ErrorMsg ctermfg=160 ctermbg=230 cterm=reverse
    hi IncSearch ctermfg=166 ctermbg=NONE cterm=standout
    hi ModeMsg ctermfg=32 ctermbg=NONE cterm=NONE
    hi MoreMsg ctermfg=32 ctermbg=NONE cterm=NONE
    hi Pmenu ctermfg=242 ctermbg=254 cterm=NONE
    hi PmenuSbar ctermfg=NONE ctermbg=247 cterm=NONE
    hi PmenuSel ctermfg=254 ctermbg=246 cterm=NONE
    hi PmenuThumb ctermfg=NONE ctermbg=66 cterm=NONE
    hi Question ctermfg=37 ctermbg=NONE cterm=bold
    hi Search ctermfg=136 ctermbg=NONE cterm=reverse
    hi SignColumn ctermfg=66 ctermbg=NONE cterm=NONE
    hi Visual ctermfg=247 ctermbg=230 cterm=reverse
    hi VisualNOS ctermfg=NONE ctermbg=254 cterm=reverse
    hi WarningMsg ctermfg=166 ctermbg=NONE cterm=bold
    hi Comment ctermfg=247 ctermbg=NONE cterm=italic
    hi Constant ctermfg=37 ctermbg=NONE cterm=NONE
    hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
    hi Error ctermfg=160 ctermbg=230 cterm=bold,reverse
    hi Identifier ctermfg=32 ctermbg=NONE cterm=NONE
    hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PreProc ctermfg=166 ctermbg=NONE cterm=NONE
    hi Special ctermfg=166 ctermbg=NONE cterm=NONE
    hi Statement ctermfg=106 ctermbg=NONE cterm=NONE
    hi Todo ctermfg=162 ctermbg=NONE cterm=bold
    hi Type ctermfg=136 ctermbg=NONE cterm=NONE
    hi Underlined ctermfg=61 ctermbg=NONE cterm=NONE
    hi NormalMode ctermfg=242 ctermbg=230 cterm=reverse
    hi InsertMode ctermfg=37 ctermbg=230 cterm=reverse
    hi ReplaceMode ctermfg=166 ctermbg=230 cterm=reverse
    hi VisualMode ctermfg=162 ctermbg=230 cterm=reverse
    hi CommandMode ctermfg=162 ctermbg=230 cterm=reverse
    if has('nvim')
      hi! link TermCursor Cursor
      hi TermCursorNC ctermfg=230 ctermbg=247 cterm=NONE
    endif
  endif
endif
