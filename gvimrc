set lines=40 columns=80

set guioptions-=r
set guioptions-=L
set guioptions-=m
set guioptions-=T
set guioptions-=M
set guioptions-=e

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

hi Normal  guifg=#e0e2e4  guibg=#000f15
hi Comment guifg=#66747b   gui=italic
hi Conditional guifg=#93c763 
hi Constant guifg=#e0e2e4  
hi Error guifg=#d39745  
hi Identifier guifg=#678cb1  
hi Ignore guifg=#e0e2e4
hi Operator guifg=#e8e2b7  
hi PreProc guifg=#6699ff  
hi Repeat guifg=#93c763  
hi Special guifg=#93c763  
hi Statement guifg=#93c763  
hi Number guifg=#ffcd22  
hi Boolean guifg=#5ab9be 
hi String guifg=#ff8409  
hi Character guifg=#ff8409  
hi Title guifg=#e0e2e4  
hi Todo guifg=#293134 guibg=#6699ff  gui=bold guisp=NONE
hi Type guifg=#678cb1  
hi Underline guifg=#5889c0 
hi Cursor guifg=#66747b  guibg=#ec7600
hi CursorIM guifg=#d39745  guibg=#ec7600
hi CursorLine guifg=NONE guibg=#2f393c
hi CursorColumn guifg=#e0e2e4  guibg=#2f393c
hi Directory guifg=#5889c0 
hi ErrorMsg guifg=#2f393c guibg=#d39745
hi FoldColumn guifg=#2f393c 
hi Folded guifg=#293134 guibg=#5ab9be
hi IncSearch guifg=#e0e2e4   gui=none
hi LineNr guifg=#66747b   gui=none
hi MatchParen guifg=#293134 guibg=#ec7600  gui=bold
hi ModeMsg guifg=#ff8409  
hi MoreMsg guifg=#ff8409  
hi NonText guifg=#e0e2e4  
hi Pmenu guifg=#e0e2e4  guibg=#66747b
hi PmenuSel guifg=#2f393c guibg=#678cb1
hi Question guifg=#6699ff  
hi Search guifg=#000000 guibg=#93c763
hi SpecialKey guifg=#5889c0 
hi StatusLine guifg=#e0e2e4  guibg=#678cb1  gui=none
hi StatusLineNC guifg=#e0e2e4 guibg=#66747b  gui=none
hi TabLine guifg=#66747b   gui=none
hi TabLineFill guifg=#293134 guibg=#2f393c gui=none
hi TabLineSel guifg=#e0e2e4  guibg=#2f393c gui=none
hi Tooltip guifg=#678cb1  guibg=#66747b  gui=none
hi VertSplit guifg=#6699ff  guibg=#2f393c gui=none
hi Visual  guifg=#e0e2e4  guibg=#6699ff  gui=none
hi VisualNOS gui=none guibg=black
hi WarningMsg  guifg=#ff8409    gui=none
hi WildMenu  guifg=#f3db2e  guibg=#ff8409  gui=none
