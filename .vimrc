" Blake Matheny vimrc

" ========== First Settings ==========
" These are settings that should be first, so that when pathogen loads plugins they are respected
set nocompatible
let mapleader="," " , is just easier to type than \

" This must be set before nerdtree is loaded. Allows you to specify per directory bookmarks
if filereadable(".NERDTreeBookmarks")
	let NERDTreeBookmarksFile=".NERDTreeBookmarks"
endif

" Need to enable these before pathogen loads plugins otherwise some plugins (looking at you VimOrganizer) break
filetype plugin on
filetype indent on

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
set scrolljump=5               " Scroll 5 lines at a time
syn sync fromstart             " Sync whole file


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
set textwidth=80

" matchit requires that plugin be on before it's loaded, and should be loaded
" before we pull in any language plugins
runtime macros/matchit.vim

" ========== Completion ==========

set wildmode=list:longest
set wildmenu                " enable ctrl-n/ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~ " stuff to ignore automatically
set wildignore+=*.lo,*.la,*.class,*.jar,*.gem
set wildignore+=*.rej,.*.rej
set wildignore+=*.png,*.jpg,*.gif,*DS_Store*
set wildignore+=*.swp
set wildignore+=*.orig " ignore mercurial backups


" ========== Swap/Undo File Settings ==========

set backupdir=~/.vim-swap,~/.tmp,~/tmp,/var/tmp,/tmp " Use ~/.vim-swap
set directory=~/.vim-swap,~/.tmp,~/tmp,/var/tmp,/tmp " Use ~/.vim-swap
set undodir=~/.vim-undo                              " Use ~/.vim-undo
set undofile                                         " Use it
set updatetime=60000                                 " Write to swap every 60s

" ========== Visuals ==========

set showmatch                        " Show matching brace
set showmode                         " Good if vim-powerline not installed
set ruler                            " Good if vim-powerline not installed
set rulerformat=%17(%l/%L,%c\ %p%%%) " Good if vim-powerline not installed
set cursorline                       " Current line is highlighted

for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor
