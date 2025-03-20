if [ -f ~/.cache/bmatheny/ruby.zsh ]; then
  source ~/.cache/bmatheny/ruby.zsh
else
  setopt append_create
  _t_rpath=""
  _t_gpath=""
  # If we are using homebrew, assume we have homebrew ruby and set environment accordingly
  if (( $+commands[brew] )); then
    if [ $(brew --prefix ruby 2>/dev/null) ]; then
      _t_rpath="$(brew --prefix ruby)/bin"
      _t_gpath="$(gem environment gemdir)/bin"
    fi
  fi
  # Not a homebrew environment so...
  if [ -z "$_t_rpath" ]; then
    # Setup gem path only and assume we are using system ruby
    _t_gpath="$(gem environment user_gemhome)/bin"
    # If user_gemhome isn't available
    if [ $? -eq 1 ]; then
      # Fallback to using ruby directly to get the user_dir
      _t_gpath=$(ruby -e "puts Gem.user_dir")/bin
    fi
  fi
  if [ ! -z "$_t_rpath" ]; then
    echo "path=(\"${_t_rpath}\" \$path)" >> ~/.cache/bmatheny/ruby.zsh
  fi
  if [ ! -z "$_t_gpath" ]; then
    echo "path=(\"${_t_gpath}\" \$path)" >> ~/.cache/bmatheny/ruby.zsh
  fi
fi
