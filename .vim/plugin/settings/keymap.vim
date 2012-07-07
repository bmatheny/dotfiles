" ========== Keyboard Mappings ==========

" nmap for normal mode, vmap for visual mode, imap for insertion mode

nmap <silent> <Leader>pt :set invpaste<CR>
nmap <silent> <Leader>ll :set tw=30000<CR>

nmap <silent> <Leader>q :copen<CR>
nmap <silent> <Leader>qc :cclose<CR>

" Move down by method with C-j
nmap <silent> <C-j> ]m
" Move up by method with C-k
nmap <silent> <C-k> [m

" ack search for the word under the cursor using the current filetype as an argument to ack
execute "map <silent> <Leader>aw :Ack --" . &ft . " <cword><CR>"
