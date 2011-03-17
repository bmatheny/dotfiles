autocmd BufNewFile *.java 0r ~/src/templates/skeleton.java
au FileType java		set ai tabstop=4 expandtab

let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1
