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
set number relativenumber

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

" Indents and formats for YAML
autocmd FileType yaml set sw=2

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

"Airline theme configuration {{{
let TERM = split(system("echo $TERM"), '[^a-z]')[0]

if !(TERM ==# "linux")
    " Powerline fonts for airline
    let g:airline_powerline_fonts = 1

    scriptencoding utf-8

    " Airline themes are generated based on the following concepts:
    "   * The section of the status line, valid Airline statusline sections are:
    "       * airline_a (left most section)
    "       * airline_b (section just to the right of airline_a)
    "       * airline_c (section just to the right of airline_b)
    "       * airline_x (first section of the right most sections)
    "       * airline_y (section just to the right of airline_x)
    "       * airline_z (right most section)
    "   * The mode of the buffer, as reported by the :mode() function.  Airline
    "     converts the values reported by mode() to the following:
    "       * normal
    "       * insert
    "       * replace
    "       * visual
    "       * inactive
    "       The last one is actually no real mode as returned by mode(), but used by
    "       airline to style inactive statuslines (e.g. windows, where the cursor
    "       currently does not reside in).
    "   * In addition to each section and mode specified above, airline themes
    "     can also specify overrides.  Overrides can be provided for the following
    "     scenarios:
    "       * 'modified'
    "       * 'paste'
    "
    " Airline themes are specified as a global viml dictionary using the above
    " sections, modes and overrides as keys to the dictionary.  The name of the
    " dictionary is significant and should be specified as:
    "   * g:airline#themes#<theme_name>#palette
    " where <theme_name> is substituted for the name of the theme.vim file where the
    " theme definition resides.  Airline themes should reside somewhere on the
    " 'runtimepath' where it will be loaded at vim startup, for example:
    "   * autoload/airline/themes/theme_name.vim
    "
    " For this, the dark.vim, theme, this is defined as
    let g:airline#themes#dark#palette = {}

    " Keys in the dictionary are composed of the mode, and if specified the
    " override.  For example:
    "   * g:airline#themes#dark#palette.normal
    "       * the colors for a statusline while in normal mode
    "   * g:airline#themes#dark#palette.normal_modified
    "       * the colors for a statusline while in normal mode when the buffer has
    "         been modified
    "   * g:airline#themes#dark#palette.visual
    "       * the colors for a statusline while in visual mode
    "
    " Values for each dictionary key is an array of color values that should be
    " familiar for colorscheme designers:
    "   * [guifg, guibg, ctermfg, ctermbg, opts]
    " See "help attr-list" for valid values for the "opt" value.
    "
    " Each theme must provide an array of such values for each airline section of
    " the statusline (airline_a through airline_z).  A convenience function,
    " airline#themes#generate_color_map() exists to mirror airline_a/b/c to
    " airline_x/y/z, respectively.

    " The dark.vim theme:
    let s:airline_a_normal   = [ '#00005f' , '#dfff00' , 17  , 190 ]
    let s:airline_b_normal   = [ '#ffffff' , '#444444' , 255 , 238 ]
    let s:airline_c_normal   = [ '#9cffd3' , '#202020' , 85  , 234 ]
    let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

    " It should be noted the above is equivalent to:
    " let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(
    "    \  [ '#00005f' , '#dfff00' , 17  , 190 ],  " section airline_a
    "    \  [ '#ffffff' , '#444444' , 255 , 238 ],  " section airline_b
    "    \  [ '#9cffd3' , '#202020' , 85  , 234 ]   " section airline_c
    "    \)
    "
    " In turn, that is equivalent to:
    " let g:airline#themes#dark#palette.normal = {
    "    \  'airline_a': [ '#00005f' , '#dfff00' , 17  , 190 ],  "section airline_a
    "    \  'airline_b': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_b
    "    \  'airline_c': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_c
    "    \  'airline_x': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_x
    "    \  'airline_y': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_y
    "    \  'airline_z': [ '#00005f' , '#dfff00' , 17  , 190 ]   "section airline_z
    "    \}
    "
    " airline#themes#generate_color_map() also uses the values provided as
    " parameters to create intermediary groups such as:
    "   airline_a_to_airline_b
    "   airline_b_to_airline_c
    "   etc...

    " Here we define overrides for when the buffer is modified.  This will be
    " applied after g:airline#themes#dark#palette.normal, hence why only certain keys are
    " declared.
    let g:airline#themes#dark#palette.normal_modified = {
                \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 53      , ''     ] ,
                \ }


    let s:airline_a_insert = [ '#00005f' , '#00dfff' , 17  , 45  ]
    let s:airline_b_insert = [ '#ffffff' , '#005fff' , 255 , 27  ]
    let s:airline_c_insert = [ '#ffffff' , '#000080' , 15  , 17  ]
    let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
    let g:airline#themes#dark#palette.insert_modified = {
                \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 53      , ''     ] ,
                \ }
    let g:airline#themes#dark#palette.insert_paste = {
                \ 'airline_a': [ s:airline_a_insert[0]   , '#d78700' , s:airline_a_insert[2] , 172     , ''     ] ,
                \ }


    let g:airline#themes#dark#palette.replace = copy(g:airline#themes#dark#palette.insert)
    let g:airline#themes#dark#palette.replace.airline_a = [ s:airline_b_insert[0]   , '#af0000' , s:airline_b_insert[2] , 124     , ''     ]
    let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified


    let s:airline_a_visual = [ '#000000' , '#ffaf00' , 232 , 214 ]
    let s:airline_b_visual = [ '#000000' , '#ff5f00' , 232 , 202 ]
    let s:airline_c_visual = [ '#ffffff' , '#5f0000' , 15  , 52  ]
    let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
    let g:airline#themes#dark#palette.visual_modified = {
                \ 'airline_c': [ '#ffffff' , '#5f005f' , 255     , 53      , ''     ] ,
                \ }


    let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
    let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
    let s:airline_c_inactive = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
    let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
    let g:airline#themes#dark#palette.inactive_modified = {
                \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
                \ }

    " For commandline mode, we use the colors from normal mode, except the mode
    " indicator should be colored differently, e.g. blue on light green
    let s:airline_a_commandline   = [ '#00005f' , '#dfff00' , 17 , 178 ]
    let s:airline_b_commandline   = [ '#ffffff' , '#444444' , 255 , 238 ]
    let s:airline_c_commandline   = [ '#9cffd3' , '#202020' , 85  , 234 ]
    let g:airline#themes#dark#palette.commandline = airline#themes#generate_color_map(s:airline_a_commandline, s:airline_b_commandline, s:airline_c_commandline)

    " Accents are used to give parts within a section a slightly different look or
    " color. Here we are defining a "red" accent, which is used by the 'readonly'
    " part by default. Only the foreground colors are specified, so the background
    " colors are automatically extracted from the underlying section colors. What
    " this means is that regardless of which section the part is defined in, it
    " will be red instead of the section's foreground color. You can also have
    " multiple parts with accents within a section.
    let g:airline#themes#dark#palette.accents = {
                \ 'red': [ '#ff0000' , '' , 160 , ''  ]
                \ }


    " Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
    " variable so that related functionality is loaded iff the user is using
    " ctrlp. Note that this is optional, and if you do not define ctrlp colors
    " they will be chosen automatically from the existing palette.
    if get(g:, 'loaded_ctrlp', 0)
        let g:airline#themes#dark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
                    \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
                    \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
                    \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])
    endif

endif

" }}}
" }}}
