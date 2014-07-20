if [[ "$OSTYPE" == darwin* ]]; then
  if (( $+commands[brew] )); then
    path=("$(brew --prefix coreutils)/libexec/gnubin" "$path[@]")
  fi
fi
