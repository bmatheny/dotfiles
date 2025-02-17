call plug#begin("~/.cache/vim/plugs")

" ========== General vim Improvements ==========
" Look at https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
" This cleaned up my config a lot since I had a number of these settings
Plug 'tpope/vim-sensible'


" ========== Git ==========
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'


" ========== Languages ==========
Plug 'rhysd/vim-gfm-syntax'


" ========== Look ==========
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" ========== Navigation ==========
Plug 'jlanzarotta/bufexplorer'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'


" ========== Search ==========
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

call plug#end()
