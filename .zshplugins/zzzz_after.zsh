# Load after files

after_dir="$HOME/.zsh.after"
if [ -d $after_dir ]; then
  if [ "$(ls -A $after_dir)" ]; then
    for config_file ($after_dir/*.zsh) source $config_file
  fi
fi
unset after_dir
