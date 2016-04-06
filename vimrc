syntax on
if $TERM=="xterm"
    set t_Co=256
    hi LineNr ctermfg=darkgrey
    hi Normal ctermbg=235
    set background=dark
endif

set ignorecase hlsearch number smarttab shiftwidth=4 exrc secure autoread

au FileType make set noet ci pi sts=0 sw=4 ts=4 "Indents and formats for makefiles
au BufRead,BufNewFile *.php set ft=html "Format php as html

:filetype plugin on
:filetype indent on
:imap ;; <Esc>
:nmap <C-v> "+p
:nmap <C-l> gg=G
:map <C-c> "+y
:nmap <Space> i
command E :execute ':Explore'
command W :execute ':silent :w !sudo tee % > /dev/null' | edit!
command R :execute ':w ! racket -f % -i'
command L :exec Latex()


function Latex()
    :w
    :!pdflatex %
endfunction

:map <C-p> ciw"<C-r>""<Esc>
:map <C-o> j.
