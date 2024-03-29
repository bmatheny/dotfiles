# vim: set ft=zsh:

function gem_install() {
  local file="$1"
  local required=$2

  brew_source
  check_cmds "ruby"
  check_file "${file}" $required
  if (( ! $+commands[bundle] )); then
    echo "Installing bundler to process Gemfile '${file}'"
    gem install bundler
  fi
  bundle install --gemfile="${file}"
}
