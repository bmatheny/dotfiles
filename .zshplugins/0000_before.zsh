# Load before files

if [[ "$OSTYPE" == darwin* ]]; then
  if (( $+commands[brew] )); then
    path=("$(brew --prefix coreutils)/libexec/gnubin" $path)
  fi
fi

before_dir="$HOME/.zshplugins/zsh.before"
if [ -d $before_dir ]; then
  if [ "$(ls -A $before_dir)" ]; then
    for config_file ($before_dir/*.zsh) source $config_file
  fi
fi
unset before_dir
