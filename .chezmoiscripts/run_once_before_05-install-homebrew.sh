#!/usr/bin/env zsh
# vim: set ft=zsh:

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
}

# Create a robust platform name string so that if homebrew is installed in a
# location using this name, it will work on that machine.
function get_platform_name() {
  local os_type=$(uname -s) # Darwin, Linux
  local machine_type=$(uname -m) # x86_64, arm64, aarch64
  local flavor="" # rocky, ubuntu, 12.6 (for mac)
  if [[ -s "/etc/os-release" ]]; then
    source "/etc/os-release"
    if [ -n "${ID}" ]; then
      flavor="${ID}_${VERSION_ID:-Unknown}"
    fi
    if [[ "$OSTYPE" == darwin* ]]; then
      flavor="$(sw_vers -productVersion)"
    fi
  fi
  if [ -z "${flavor}" ]; then
    flavor="unknown"
  fi
  echo "${os_type}-${machine_type}-${flavor}" # e.g. Linux-x86_64-rocky
}

cd $HOME

if (( $+commands[brew] )); then
  echo "Found existing brew installation, exiting with success"
  exit 0
fi

if (( ! $+commands[git] )); then
  echo "Unable to find git and can not run without it, exiting with error"
  exit 1
fi

typeset -l HOMEBREW_PLATFORM_NAME=$(get_platform_name)
_homebrew_home="${HOME}/.homebrew/${HOMEBREW_PLATFORM_NAME}"

if [[ -d "${_homebrew_home}" ]]; then
  echo "Found existing homebrew directory at '${_homebrew_home}', exiting with error"
  echo "Remove this directory if you want to use this script"
  exit 1
fi

git clone https://github.com/Homebrew/brew "${_homebrew_home}" || error_fn "git clone failed"
eval "$(${_homebrew_home}/bin/brew shellenv)"
brew update --force --quiet || error_fn "brew update failed"
chmod -R go-w "$(brew --prefix)/share/zsh" || error_fn "chmod failed"

# This is a pre-requisite for most of the other scripts used for managing software
brew bundle --file=- <<EOF
brew "chezmoi"
EOF

exit 0
