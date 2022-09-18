let g:gfm_syntax_enable_always = 0
let g:gfm_syntax_enable_filetypes = ['markdown.gfm']
autocmd BufRead,BufNew,BufNewFile README.md setlocal ft=markdown.gfm
let g:markdown_fenced_languages = ['bash', 'cpp', 'ruby']
