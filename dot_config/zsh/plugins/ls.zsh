if [[ -f "${HOME}/.dircolors" ]]; then
  if (( $+commands[dircolors] )); then
    eval `dircolors -b $HOME/.dircolors`
  fi
fi
