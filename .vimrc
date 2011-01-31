" Blake Matheny vimrc $Revision$

" ****************************************************************************
" General Settings
" ****************************************************************************
set nocompatible

" By default ignore the case of searches
set ignorecase

" Default the textwidth to 78
set tw=78

" How to operate in insert mode for BS
set backspace=indent,eol,start

" Enhanced command-line completion
set wildmenu

" Files to ignore
set wildignore=*.o,*.lo,*.la,#*#,.*.rej,*.rej,.*~,*~,.#*,*.class

set tags=~/.vim/mytags/blog

" ****************************************************************************
" Visuals
" ****************************************************************************
" Show visually what is being done
set	showcmd

" Highlight our search
set	hlsearch

" Show matching brace
set showmatch

" Show me when I mess up
set visualbell

" Let me know I'm doing something
set showmode

" Show me how my search is doing
set incsearch

" Show me a ruler
set ruler



" ****************************************************************************
" Software Development
" ****************************************************************************
syntax on

" How do we format code?
set formatoptions=tcro

" Skeleton Files
autocmd BufNewFile *.pl 0r ~/src/templates/skeleton.pl

" Set file types for uncommon extensions
au BufRead,BufNewFile *.sc setfiletype scheme

" Language Specific Options
au FileType c			set cindent
au FileType javascript		set ai cindent tw=3000
au FileType perl		set cindent
au FileType cpp			set cindent
au FileType php			set cindent tw=85
au FileType xml			set ai
au FileType mkd			set ai formatoptions=tcroqn2 comments=n:>
au FileType cucumber		set ai tw=120 ts=2
au FileType ruby		set shiftwidth=2 softtabstop=2

augroup php
	autocmd BufNewFile *.php 0r ~/src/templates/skeleton.php
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	set foldmethod=marker
augroup END

augroup java
	autocmd BufNewFile *.java 0r ~/src/templates/skeleton.java
	au FileType java		set ai tabstop=4 expandtab
augroup END
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

source ~/.vim/python.vim
cabbr jslint !~/bin/js.sh ~/src/js/runjslint.js "`cat %`" \| ~/src/js/format_lint_output.py

" Some abbreviations
ab #d #define
ab #i #include <
iab mainf int main (int argc, char ** argv)



" ****************************************************************************
" Keyboard Mappings
" ****************************************************************************

" c-d deletes characters in insert mode
imap <c-d> <c-o>x

" c-{jklh} moves around in insert mode
imap <c-j> <c-o>j
imap <c-k> <c-o>k
imap <c-l> <c-o>l
imap <c-h> <c-o>h

" c-e moves to the end of a line
imap <c-e> <c-o>$

" c-a moves to the beginning of a line
imap <c-a> <c-o>^

" c-u undoes what you just did
imap <c-u> <c-o>u

" Navigate screens in insert mode
imap <c-w>k <c-o><c-w>k
imap <c-w>j <c-o><c-w>j
imap <c-w>l <c-o><c-w>l
imap <c-w>h <c-o><c-w>h

" Toggle paste
set pastetoggle=<F7>

" When you're stuck in long line hell
map <F8> :set tw=30000<cr>

" Preview markdown, delete markdown
map pm :w!<CR>:!markdown % \| smartypants > %.html && open %.html<CR><CR>
map dm :!rm -f %.html<CR><CR>

" ****************************************************************************
" Custom Colors
" ****************************************************************************
colorscheme peachpuff
hi! Comment ctermfg=white ctermbg=black
hi! Search ctermfg=green ctermbg=white

" ****************************************************************************
" Misc Stuff
" ****************************************************************************
filetype plugin on
filetype indent on

" ****************************************************************************
" Spelling Stuff
" ****************************************************************************
" setlocal spell spelllang=en_us
" highlight clear SpellBad
" highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
" highlight clear SpellCap
" highlight SpellCap term=underline cterm=underline
" highlight clear SpellRare
" highlight SpellRare term=underline cterm=underline
" highlight clear SpellLocal
" highlight SpellLocal term=underline cterm=underline

" Use ack instead of grep because ack rocks
set grepprg=~/bin/ack\ -a
