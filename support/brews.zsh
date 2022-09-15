# vim: set ft=zsh:

function _check_cmds() {
  (( $+commands[brew] )) || error_fn "Could not find homebrew"
  (( $+commands[chezmoi] )) || error_fn "Could not find chezmoi"
}

function _check_file() {
  local readonly file="$1"
  local readonly required=$2

  if [[ ! -f $file ]]; then
    if [[ $required -eq 1 ]]; then
      error_fn "Could not find file '$file'"
    else
      exit 0
    fi
  fi
}

function brew_install() {
  local readonly file="$1"
  local readonly required=$2

  brew_source
  _check_cmds
  _check_file "${file}" $required
  brew bundle --quiet --file="${file}"
}
