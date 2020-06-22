#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

path+=("/usr/local/bin")

if [[ "$OSTYPE" == darwin* ]]; then
  if (( $+commands[brew] )); then
    if [ $(brew --prefix coreutils 2>/dev/null) ]; then
      path=("$(brew --prefix coreutils)/libexec/gnubin" $path)
    fi
  fi
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

for config_file ($HOME/.zshplugins/*.zsh) source $config_file
