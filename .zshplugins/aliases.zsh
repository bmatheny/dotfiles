alias l='ls --color'
alias lsize='ls --color=always -sh'

# more is less
alias more='less'

# vim stuff
alias vim="vim -o $@"
alias vtree="vim +NERDTree +TagbarOpen"
alias vi=vim
alias v="f -t -e vim"

# dev stuff
alias diff=colordiff
alias tmux='tmux -2'
alias -g ff='ack -g'
alias -g XS='| egrep -v \\.svn\|\\.class$\|\\.git'
alias gd='git diff'
compdef _git gd=git-diff
