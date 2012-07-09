" ========== Keyboard Mappings ==========

" nmap for normal mode, vmap for visual mode, imap for insertion mode

nmap <silent> <Leader>pt :set invpaste<CR>
nmap <silent> <Leader>ll :set tw=30000<CR>

nmap <silent> <Leader>q :copen<CR>
nmap <silent> <Leader>qc :cclose<CR>

" NOTE: Stealing m breaks marks, but I don't use those

" Move to the next method
nmap <silent> mj ]m
" Move to the previous method
nmap <silent> mk [m

" Move to the definition
nmap <silent> md <C-]>
" Move back
nmap <silent> mb <C-T>

" ack search for the word under the cursor using the current filetype as an argument to ack
execute "map <silent> <Leader>aw :Ack --" . &ft . " <cword><CR>"
