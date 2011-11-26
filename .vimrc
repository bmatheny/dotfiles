" Blake Matheny vimrc $Revision$

" ****************************************************************************
" General Settings
" ****************************************************************************
set nocompatible

if filereadable(".NERDTreeBookmarks")
	let NERDTreeBookmarksFile=".NERDTreeBookmarks"
endif
let PHP_outdentphpescape=0

" Enable pathogen for easy plugin handling
runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

" By default ignore the case of searches
set ignorecase

" Default the textwidth to 78
set tw=78

" How to operate in insert mode for BS
set backspace=indent,eol,start

" Enhanced command-line completion
set wildmenu

" Files to ignore
set wildignore=*.o,*.lo,*.la,#*#,.*.rej,*.rej,.*~,*~,.#*,*.class,*.swp,*.jar

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

" Set ruler for show current line/total lines,column percentage
set rulerformat=%17(%l/%L,%c\ %p%%%)

" Store more history
set history=1000


" ****************************************************************************
" Software Development
" ****************************************************************************

" How do we format code?
set formatoptions=tcro

" Skeleton Files
autocmd BufNewFile *.pl 0r ~/src/templates/skeleton.pl
"autocmd BufNewFile *.php 0r ~/src/templates/skeleton.php

" Set file types for uncommon extensions
au BufRead,BufNewFile *.sc setfiletype scheme
au BufRead,BufnewFile *.ejs setfiletype erb

" Language Specific Options
au FileType c			set cindent
au FileType scala		set si et sw=2 st=2 tw=100
au FileType javascript		set ai cindent tw=3000
au FileType perl		set cindent
au FileType cpp			set cindent
au FileType smarty		set tw=500 colorcolumn=500
au FileType xml			set ai tw=3000
au FileType mkd			set ai formatoptions=tcroqn2 comments=n:>
au FileType cucumber		set ai tw=120 ts=2
au FileType ruby		set shiftwidth=2 softtabstop=2

function JSLint()
	let s:home_dir = expand("~/")
	let s:file_name = expand("%:p")
	let s:js_sh = s:home_dir . 'bin/js.sh'
	let s:js_run = s:home_dir . 'src/js/runjslint.js'
	let s:cmd = s:js_sh . ' ' . s:js_run . " \"`cat " . s:file_name . "`\""
  	botright new
    	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        call setline(1, 'Ran ' . s:cmd)
	execute '$read !'. s:cmd
	setlocal nomodifiable
endfunction
command -nargs=0 JSLint call JSLint()

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
map <Leader>pm :Hammer<CR>
map <Leader>dm :!rm -f /tmp/%.html<CR>

" Tagbar Bindings
map <Leader>b :TagbarToggle<CR>
set tags=./tags,tags,~/src/tags/commontags

" Custom key bindings for command-t
let g:CommandTAcceptSelectionMap=[]
let g:CommandTAcceptSelectionSplitMap=['<C-CR>','<CR>']

" ****************************************************************************
" Custom Colors
" ****************************************************************************
let g:solarized_termcolors=16
set background=dark
colorscheme solarized
syn sync fromstart

syntax on
filetype plugin indent on

" Use ack instead of grep because ack rocks
set grepprg=~/bin/ack\ --column\ --nocolor\ --nogroup
set grepformat=%f:%l:%c:%m

" Stuff for tabs
map ,t gt<CR>
map ,T gT<CR>
