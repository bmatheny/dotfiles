# https://github.com/blinks zsh theme

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}+ %{%f%k%b%}"
  else
    echo ' '
  fi
}

function _current_ruby_prompt() {
  # Grab the current version of ruby in use (via RVM): [ruby-1.8.7]
  if which rvm-prompt &> /dev/null; then
    ZSH_THEME_CURRENT_RUBY_=" [%{%B%F{magenta}%}$(~/.rvm/bin/rvm-prompt i v)${%B%F{green}%}]"
  else
    if which rbenv &> /dev/null; then
      ZSH_THEME_CURRENT_RUBY_=" [%{%B%F{magenta}%}ruby@$(rbenv version-name)%{%B%F{green}%}]"
    fi
  fi
  if [ -z "$ZSH_THEME_CURRENT_RUBY_" ]; then
    ZSH_THEME_CURRENT_RUBY_=""
  fi
  echo "$ZSH_THEME_CURRENT_RUBY_"
}

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{black}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{black}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{black}%}%~%{%B%F{green}%}$(_current_ruby_prompt)%E%{%f%k%b%}
%{%K{black}%}$(_prompt_char)%{%K{black}%} %#%{%f%k%b%} '

RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%} '
