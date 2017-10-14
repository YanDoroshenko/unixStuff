" Synax highlighting
syntax on

" Color scheme settings for virtual console
set t_Co=256
hi LineNr ctermfg=darkgrey
hi Normal ctermbg=235
set background=dark

" Case insensitive search by default
set ignorecase

" Highlight all search matches
set hlsearch

" Show line numbers
set number

" Tab produces shiftwidth spaces
set smarttab shiftwidth=4

" Load default config file (securely)
set exrc secure

" Files are not realoaded until external command
set autoread

" More natural splitting
set splitbelow

" Indents and formats for makefiles
au FileType make set noet ci pi sts=0 sw=4 ts=4

" GCC integration
au BufEnter *.cpp compiler gcc

" Enable plugins for file types (.c, .java, .python, Makefile, etc.) and indent files accordingly
:filetype plugin indent on
:filetype plugin on

" Surround the word with quotes on Ctrl+p
:map <C-p> ciw"<C-r>"

" Repeat action on the next line on Ctrl+o
:map <C-o> j.<Esc>

" Select everything on Ctrl+a
:map <C-a> ggvG$

" Copy to system clipboard on Ctrl+c
:map <C-c> +y

" Cut to system clipboard on Ctrl+x
:map <C-x> +d

" Paste from system clipboard on Ctrl+v
:imap <C-v> <Esc>"+gpa

" Map Esc to ;; in Insert mode
:imap ;; <Esc>

" Map Esc to ;; in Visual mode
:vmap ;; <Esc>

" Reformat the whole file on Ctrl+l
:nmap <C-l> gg=G

" Enter Insert mode on Space
:nmap <Space> i

" Add a closing tag
:inoremap <F8> </<C-X><C-O>

" Remove unnecessary empty lines
map <F7> :%s/\n\{3,}/\r\r/e<Enter>:noh<Enter>

" Reasonable regex handling
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Run Explore vertically
command E :exec Explore!

" Launch the edited file
command XX :exec Run()

" Save as sudo
command W :exec ':silent w !sudo tee % > /dev/null' | :edit!

" Execute Latex() function
command L :exec Latex()

" Zip the current file
command Z :exec Zip()

" Function that saves and compresses the current file
function Zip()
    :w
    :silent !zip %:r.zip %
    :redraw!
endfunction

" Function to build Latex files
function Latex()
    :w
    :!pdflatex %
endfunction

" Run function
function Run()
    :w
    :!chmod +x %; ./%
endfunction

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

" Powerline fonts for airline
let g:airline_powerline_fonts = 1

" Show all buffers in case of a single tab
let g:airline#extensions#tabline#enabled = 1
