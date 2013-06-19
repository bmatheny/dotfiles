alias l='ls --color'
alias lsize='ls --color=always -sh'

# less is more
alias more='less'

# vim stuff
alias vim="nocorrect vim -o $@"
alias vtree="vim +NERDTree +TagbarOpen"
alias vi=vim
alias v="f -t -e vim"

# Ignore helpers
local IGNORES='\\.svn\|\\.git'
local OBJS='\\.class$'
alias -g XS="| egrep -v ${IGNORES}\|${OBJS}"
alias -g XSF=" -type f | egrep -v ${IGNORES}\|${OBJS}"
alias -g XSS="| egrep -v ${IGNORES}\|${OBJS}\|/target/"
alias -g XSSF=" -type f | egrep -v ${IGNORES}\|${OBJS}\|/target/"

# dev stuff
alias diff=colordiff
alias ackk='ack -k'
alias tmux='tmux -2'
alias -g ff='ack -g'
alias gd='git diff'
compdef _git gd=git-diff
