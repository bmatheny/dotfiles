let NERDTreeMinimalUI = 1  " Hides the --bookmarks-- header
let NERDTreeDirArrows = 1  " fancy arrows
let NERDTreeShowHidden = 1 " Show hidden directories
let NERDTreeWinSize = 20   " A bit more narrow
let NERDTreeIgnore=['\.o$', '\~$', '\.deps$', '\.libs$', '\.orig$']

nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>nf :NERDTreeFind<CR>
