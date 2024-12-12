# vim: set ft=zsh:

SOURCEDIR=""

function error_fn() {
  echo "Exiting with error: '$1'"
  exit 1
}

function init_source() {
  SOURCEDIR="$1"
  if [ ! -d "${SOURCEDIR}" ]; then
    echo "Specified directory is not a directory or does not exist: '${SOURCEDIR}'"
    exit 1
  fi
}

function load_support_script() {
  local script="$1"
  if [ -z "${SOURCEDIR}" ]; then
    echo "Please call init_source first"
    exit 1
  fi
  source "${SOURCEDIR}/support/${script}"
}

function brew_source() {
  if (( ! $+commands[brew] )); then
    homebrew_locations=(
      "${HOME}/homebrew"
      "/opt/homebrew"
      "/usr/local")
    for location in $homebrew_locations; do
      if [[ -d "$location/bin" && -x "$location/bin/brew" ]]; then
        eval "$(${location}/bin/brew shellenv)"
        break
      fi
    done
  fi
}

function check_cmds() {
  # We always check for brew and chezmoi since we can't operate without them
  # Except on Linux where we don't depend on homebrew
  if [[ "$(uname)" == Darwin ]]; then
    (( $+commands[brew] )) || error_fn "Could not find homebrew"
  fi
  (( $+commands[chezmoi] )) || error_fn "Could not find chezmoi"
  if [ $# -gt 0 ]; then
    for cmd in $*; do
      (( $+commands[$cmd] )) || error_fn "Could not find ${cmd}"
    done
  fi
}

function check_file() {
  local file="$1"
  local required=$2

  if [[ ! -f $file ]]; then
    if [[ $required -eq 1 ]]; then
      error_fn "Could not find file '$file'"
    else
      exit 0
    fi
  fi
}
