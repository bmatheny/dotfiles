syn match scalaTodo "\(FIXME\|TODO\|XXX\)" contained

" Don't highlight leading whitespace in comment blocks
syn region scalaBlockComment start="\/\*\(\*\)\?" end="\*/" contains=scalaInnerComment,scalaTodo,scalaDocTags keepend
syn match scalaInnerComment "^\s\+" nextgroup=scalaInnerCommentText skipwhite conceal
syn match scalaInnerCommentText "\*.*" contained contains=scalaTodo,scalaDocTags

" Relink the new comment definitions
hi link scalaBlockComment Comment
hi link scalaInnerCommentText Comment
