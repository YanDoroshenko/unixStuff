"Syntax highlighting
syntax on 

"Color scheme settings for virtual console
if $TERM=="xterm" 
    set t_Co=256
    hi LineNr ctermfg=darkgrey
    hi Normal ctermbg=235
    set background=dark
endif

"Case insensitive search by default
set ignorecase 

"Highlight all search matches
set hlsearch 

"Show line numbers
set number 

"Tab produces shiftwidth spaces
set smarttab shiftwidth=4 

"Load default config file (securely)
set exrc secure 

"Files are not realoaded until external command
set autoread 


"Indents and formats for makefiles
au FileType make set noet ci pi sts=0 sw=4 ts=4 

"Enable plugins for file types (.c, .java, .python, Makefile, etc.) and indent files accordingly
:filetype plugin indent on 


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

"Execute Explorer() function
command E :exec Explorer() 

"Save as sudo
command W :exec 'w !sudo tee % > /dev/null' | edit! 

"Execute Latex() function
command L :exec Latex() 


"Function to build Latex files
function Latex() 
    :w           
    :!pdflatex % 
endfunction

"Function to open file explorer in vertical split mode
function Explorer() 
    :30vsp          
    :Explore       
endfunction
