alias l='ls --color'
alias lsize='ls --color=always -sh'

# less is more
alias more='less'

# colorize current day in cal
alias ccal='cal | grep --before-context 6 --after-context 6 --color -e " $(date +%e)" -e "^$(date +%e)"'

# vim stuff
alias vi=vim

# Ignore helpers
local IGNORES='\\.svn\|\\.git'
local OBJS='\\.class$'
alias -g XS="| egrep -v ${IGNORES}\|${OBJS}"

# dev stuff
alias tmux='tmux -2'
alias gd='git diff'
alias gst='git status'
alias ggpush='git push origin "$(git-branch-current 2> /dev/null)"'
