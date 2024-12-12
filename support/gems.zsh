# vim: set ft=zsh:

function gem_install() {
  local file="$1"
  local required=$2

  brew_source
  # If we have homebrew, assume we are using a homebrew installed ruby and gem binary
  # Or, install gems in user_gemhome if ruby isn't installed via homebrew, or homebrew
  # isn't available
  if (( $+commands[brew] )); then
    if [ $(brew --prefix ruby 2>/dev/null) ]; then
      path=("$(brew --prefix ruby)/bin" $path)
      path=("$(gem environment gemdir)/bin" $path)
    else
      path=("$(gem environment user_gemhome)/bin" $path)
    fi
  else
    path=("$(gem environment user_gemhome)/bin" $path)
  fi
  check_cmds "ruby"

  check_file "${file}" $required
  if (( ! $+commands[bundle] )); then
    echo "Installing bundler to process Gemfile '${file}'"
    gem install bundler
  fi
  bundle install --gemfile="${file}"
}
