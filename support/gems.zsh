# vim: set ft=zsh:

function gem_install() {
  local file="$1"
  local required=$2
  local install_user=0

  brew_source
  # If we have homebrew, assume we are using a homebrew installed ruby and gem binary
  # Or, install gems in user_gemhome if ruby isn't installed via homebrew, or homebrew
  # isn't available
  if (( $+commands[brew] )); then
    if [ $(brew --prefix ruby 2>/dev/null) ]; then
      path=("$(brew --prefix ruby)/bin" $path)
      path=("$(gem environment gemdir)/bin" $path)
    fi
  else
    path=("$(gem environment user_gemhome)/bin" $path)
    install_user=1
  fi
  check_cmds "ruby"

  check_file "${file}" $required
  if (( ! $+commands[bundle] )); then
    echo "Installing bundler to process Gemfile '${file}'"
    if ((install_user)); then
      gem install --user-install bundler
    else
      gem install bundler
    fi
  fi

  if ((install_user)); then
    bundle config set --local path $(gem environment user_gemhome)
  fi
  bundle install --gemfile="${file}"
}
