" Navigation and display {{{

" Synax highlighting
syntax on

" Color scheme settings for virtual console
set t_Co=256
set cursorline
hi CursorLineNR ctermfg=white
hi CursorLine cterm=none
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
set expandtab
set shiftwidth=4
set softtabstop=4

" Load default config file (securely)
set exrc secure

" Files are not realoaded until external command
set autoread

" More natural splitting
set splitbelow
set splitright

" Ignore unsaved buffer warning when switching between buffers
set hidden

" Remap $ to match the end of the line, not the beginning of the next
noremap $ g_
vnoremap $ g_

" Remap Esc to ;; {{{
noremap <Esc> <NOP>
inoremap <Esc> <NOP>
vnoremap <Esc> <NOP>
noremap ;; <Esc>
inoremap ;; <Esc>
vnoremap ;; <Esc>
tnoremap ;; <C-\><C-N>
" }}}

" Enter Insert mode on Space
nnoremap <Space> i

" }}}

" Handy mappings {{{

" Repeat action on the next line on Ctrl+o
noremap <C-o> @='j0.'<Esc>

" Add a closing tag
inoremap <F8> </<C-X><C-O>

" Remove unnecessary empty lines
map <F7> :%s/\n\{3,}/\r\r/e<Enter>:noh<Enter>
" }}}

" Autocommands {{{

" Folding in Vim config
autocmd FileType vim setlocal foldmethod=marker

" Indents and formats for makefiles
autocmd FileType make set noet ci pi sts=0 sw=4 ts=4

" Build TeX file
autocmd FileType tex command! L execute "normal! mz | :exec Latex()\<cr> | `z"

" Format JSON file
autocmd FileType json command! F execute "normal! Gmz:1,$!jq '.'<Cr>`z"

" Format XML file
autocmd! FileType xml command! F call FormatXML()

" git add --patch current file with Gpatch
autocmd BufReadPost * if fugitive#extract_git_dir(expand("%:p")) !=# "" | execute "command! Gpatch w | Git add --patch %" | endif

" Remove trailing whitespaces before save
autocmd BufWritePre * :silent! %smagic/\v[ \t]+$//g
" }}}

" Clipboard {{{

" Copy to system clipboard on Ctrl+c
noremap <C-c> "+y

" Cut to system clipboard on Ctrl+x
noremap <C-x> "+d

" Paste from system clipboard on Ctrl+v
inoremap <C-v> <Esc>"+gpa
" }}}

" Functions {{{

" Function that saves and compresses the current file
function! Zip()
    :w
    :silent !zip %:r.zip %
    :redraw!
endfunction

" Function to build Latex files
function! Latex()
    :w
    :!pdflatex %
endfunction

" Run function
function! Run()
    :w
    :!chmod +x %; ./%
endfunction

" Git add function
function! GitAdd(file)
    :exec join([':!git add', a:file], " ")
endfunction

" Format XML
function! FormatXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
" }}}

" Search {{{

" Reasonable regex handling
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap %s/ %smagic/\v
cnoremap \>s/ \>smagic/\v

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
" }}}

" Plugins {{{
"
" Enable plugins for file types (.c, .java, .python, Makefile, etc.) and indent files accordingly
filetype plugin indent on
filetype plugin on

" Plug plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'lambdalisue/suda.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-surround'
call plug#end()
" }}}

" Commands {{{

" Reformat the whole file
command! F normal! mzgg=G`z

" Run Explore vertically
command! E execute "40vsp | Explore | normal! <C-w>r"

" Launch the edited file
command! XX :exec Run()

" Save as sudo
command! W :exec 'w suda://%'

" Zip the current file
command! Z :exec Zip()

" Add an argument file to git
command! -nargs=1 -complete=file Ga call GitAdd(<f-args>)

" Git add --patch
autocmd BufReadPost * if fugitive#extract_git_dir(expand("%:p")) !=# "" | execute "command! Gpatch w | Git add --patch %" | endif
" }}}

" Plugin configuration {{{

" Show all buffers in case of a single tab
let g:airline#extensions#tabline#enabled = 1

"Airline theme configuration
let TERM = split(system("echo $TERM"), '[^a-z]')[0]
if TERM ==# "linux"
    let g:airline_theme = "base16"
else
    " Powerline fonts for airline
    let g:airline_powerline_fonts = 1

    let g:airline_theme = "dark_modified"
endif
" }}}
