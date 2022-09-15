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
      "/usr/local")
    for location in $homebrew_locations; do
      if [[ -d "$location/bin" && -x "$location/bin/brew" ]]; then
        eval "$(${location}/bin/brew shellenv)"
        break
      fi
    done
  fi
}
