" Try and follow the Google C++ Style Guide
" http://google-styleguide.googlecode.com/svn/trunk/cppguide.xml
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal textwidth=80
setlocal colorcolumn=80
setlocal wrap

setlocal cindent
setlocal cinoptions=h1,l1,g1,t0,i4,+4,(0,w1,W4,N-s

if exists("g:clangfmt_loaded")
  finish
endif
let g:clangfmt_loaded = 1

let g:clangfmt_path = '/Users/bmatheny/bin/clang-format-vim.py'
" Location of the clang-format utility
if !exists("g:clangfmt_prg")
  if filereadable('clang-format')
    let g:clangfmt_prg = "clang-format"
  elseif filereadable(g:clangfmt_path)
    let g:clangfmt_prg = g:clangfmt_path
  else
    finish
  endif
endif

map <C-K> :pyf /Users/bmatheny/bin/clang-format-vim.py<CR>
