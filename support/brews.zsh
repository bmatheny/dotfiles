# vim: set ft=zsh:

function _check_cmds() {
  (( $+commands[brew] )) || error_fn "Could not find homebrew"
  (( $+commands[chezmoi] )) || error_fn "Could not find chezmoi"
  (( $+commands[shyaml] )) || error_fn "Could not find shyaml"
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

function _install_brews_from_file() {
  local file="$1"
  for group in $(cat "${file}" | shyaml -q -y keys brew); do
    brewfile=""
    for brew in $(cat "${file}" | shyaml get-values "brew.${group}"); do
      brewfile="${brewfile}\nbrew \"${brew}\""
    done
    echo $brewfile | brew bundle --quiet --file=-
  done
}

function brew_install() {
  local readonly file="$1"
  local readonly required=$2

  brew_source
  _check_cmds
  _check_file "${file}" $required
  _install_brews_from_file "${file}"
}
