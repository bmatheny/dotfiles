" ========== Mappings for insert mode ==========
" These mostly try and emulate bash/zsh behavior

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
