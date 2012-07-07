" Blake Matheny vimrc

" ========== First Settings ==========
" These are settings that should be first, so that when pathogen loads plugins they are respected
set nocompatible
let mapleader="," " , is just easier to type than \

" This must be set before nerdtree is loaded. Allows you to specify per directory bookmarks
if filereadable(".NERDTreeBookmarks")
	let NERDTreeBookmarksFile=".NERDTreeBookmarks"
endif

" ========== Pathogen Initialization ==========
" https://github.com/tpope/vim-pathogen/
call pathogen#infect()   " Load all plugins in ~/.vim/bundle
call pathogen#helptags() " Invoke :helptags on all non-$VIM doc directories in runtime path

" ========== General Configuration ==========

set autoread                   " Reload files changed outside vim
set backspace=indent,eol,start " Allow backspace in indent mode
set hidden                     " Allow buffers to exist in the background
set history=1000               " More history for :cmdline
set showcmd                    " Show incomplete commands at the bottom
set visualbell                 " Tell me when I mess up
syntax on                      " Turn on syntax highlighting
set scrolloff=8                " Start scrolling when 8 lines away from margins


" ========== Search Settings ==========

set hlsearch           " Highlight searches by default
set incsearch          " Find the next match as we type the search
set viminfo='100,f1    " Save up to 100 marks, enable capital marks
set ignorecase         " Case insensitive *-style searches
set smartcase          " Case sensitive / search if there is a capital letter


" ========== Indentation Settings ==========

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set textwidth=78

filetype plugin on
filetype indent on


" ========== Completion ==========

set wildmode=list:longest
set wildmenu                " enable ctrl-n/ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~ " stuff to ignore automatically
set wildignore+=*.lo,*.la,*.class,*.jar,*.gem
set wildignore+=*.rej,.*.rej
set wildignore+=*.png,*.jpg,*.gif,*DS_Store*
set wildignore=*.swp


" ========== Swap/Undo File Settings ==========

set backupdir=~/.vim-swap,~/.tmp,~/tmp,/var/tmp,/tmp " Use ~/.vim-swap
set directory=~/.vim-swap,~/.tmp,~/tmp,/var/tmp,/tmp " Use ~/.vim-swap
set undodir=~/.vim-undo                              " Use ~/.vim-undo
set undofile                                         " Use it

" ========== Visuals ==========

set showmatch                        " Show matching brace
set showmode                         " Good if vim-powerline not installed
set ruler                            " Good if vim-powerline not installed
set rulerformat=%17(%l/%L,%c\ %p%%%) " Good if vim-powerline not installed


for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor

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
au BufRead,BufNewFile Capfile setfiletype ruby
au BufRead,BufNewFile Gemfile setfiletype ruby
au BufRead,BufNewFile *.thor setfiletype ruby

" Language Specific Options
au FileType c		set cindent
au FileType zsh         set si et sw=2 st=2 tw=120
au FileType scala	set si et sw=2 st=2 tw=100
au FileType javascript	set ai cindent tw=3000
au FileType perl	set cindent
au FileType cpp		set cindent
au FileType smarty	set tw=500 colorcolumn=500
au FileType xml		set ai tw=3000
au FileType mkd		set ai formatoptions=tcroqn2 comments=n:>
au FileType cucumber	set ai tw=120 ts=2
au FileType ruby	set tw=100 shiftwidth=2 softtabstop=2 tabstop=2 ai expandtab smarttab
au FileType treetop	set shiftwidth=2 softtabstop=2 tabstop=2 ai expandtab smarttab
au FileType puppet	set shiftwidth=2 softtabstop=2 tabstop=2 ai expandtab smarttab

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

set tags=./tags,tags,~/src/tags/commontags

" Custom key bindings for command-t
let g:CommandTAcceptSelectionMap=[]
let g:CommandTAcceptSelectionSplitMap=['<C-CR>','<CR>']

" ****************************************************************************
" Custom Colors
" ****************************************************************************
set cursorline
syn sync fromstart

let laststatus=2

" Use ack instead of grep because ack rocks
set grepprg=~/bin/ack\ --column\ --nocolor\ --nogroup
set grepformat=%f:%l:%c:%m
