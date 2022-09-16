# vim: set ft=zsh:

function brew_install() {
  local file="$1"
  local required=$2

  brew_source
  check_cmds
  check_file "${file}" $required
  brew bundle --quiet --file="${file}"
}
