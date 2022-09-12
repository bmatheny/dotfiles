# Load before files

before_dir="$HOME/.config/zsh/before"
if [ -d $before_dir ]; then
  if [ "$(ls -A $before_dir)" ]; then
    for config_file ($before_dir/*.zsh) source $config_file
  fi
fi
unset before_dir
