syntax on
if $TERM=="xterm"
    set background=dark
    let g:colors_name="monokai"
    hi Normal ctermfg=231 ctermbg=235 cterm=NONE guifg=#f8f8f2 guibg=#272822 gui=NONE
endif
highlight LineNr ctermfg=darkgrey
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
