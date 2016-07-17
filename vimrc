syntax on "Syntax highlightign

if $TERM=="xterm" "Color scheme settings for virtual console
    set t_Co=256
    "hi LineNr ctermfg=darkgrey
    hi Normal ctermbg=235
    set background=dark
endif

set ignorecase "Case insensitive search by default
set hlsearch "Highlight all search matches
set number "Show line numbers
set smarttab shiftwidth=4 "Tab produces shiftwidth spaces
set exrc secure "Load default config file (securely)
set autoread "Files are not realoaded until external command

au FileType make set noet ci pi sts=0 sw=4 ts=4 "Indents and formats for makefiles
au BufRead,BufNewFile *.php set ft=html "Format php as html

:filetype plugin indent on "Enable plugins for file types (.c, .java, .python, Makefile, etc.) and indent files accordingly

"Surround the word with quotes on Ctrl+p
:map <C-p> ciw"<C-r>""<Esc> 

"Repeat action on the next line on Ctrl+o
:map <C-o> j. 

"Select everything on Ctrl+a
:map <C-a> ggvG$

"Copy to system clipboard on Ctrl+c
:map <C-c> "+y

"Cut to system clipboard on Ctrl+x
:map <C-x> "+d

"Paste from system clipboard on Ctrl+v
:nmap <C-v> "+p

"Map Esc to ;; in Insert mode
:imap ;; <Esc>

"Reformat the whole file on Ctrl+l
:nmap <C-l> gg=G

"Enter Insert mode on Space
:nmap <Space> i

command E :exec Explorer() "Execute Explorer() function
command W :exec 'w !sudo tee % > /dev/null' | edit! "Save as sudo
command L :exec Latex() "Execute Latex() function


function Latex() "Function to build Latex files
    :w           "Save
    :!pdflatex % "Run pdflatex on current file
endfunction

function Explorer() "Function to open file explorer in vertical split mode
    :30vsp          "Split
    :Explore        "Open explorer
endfunction
