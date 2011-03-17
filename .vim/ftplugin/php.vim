autocmd BufNewFile *.php 0r ~/src/templates/skeleton.php
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set foldmethod=marker
set colorcolumn=86
set cindent
set tw=85
