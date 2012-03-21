syn match myComments "\(FIXME\|TODO\|XXX\)" contained
syn match lineComment "//.*" contains=myComments
hi link lineComment Comment
hi link myComments Todo
