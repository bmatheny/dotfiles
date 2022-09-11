" Discard default selection key mappings
let g:CommandTAcceptSelectionMap=[]

" Open split on enter or control enter
let g:CommandTAcceptSelectionSplitMap=['<C-CR>','<CR>']

" Override default before explorer to use MRU one
nnoremap <silent> <Leader>b :CommandTMRU<CR>
