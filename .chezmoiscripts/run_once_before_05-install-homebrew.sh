#!/usr/bin/env zsh
# vim: set ft=zsh:

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
}

cd $HOME

if [[ "$(uname)" != Darwin ]]; then
  echo "Only installing homebrew on Darwin, exiting"
  exit 0
fi

if (( $+commands[brew] )); then
  echo "Found existing brew installation, exiting with success"
  exit 0
fi

if (( ! $+commands[git] )); then
  echo "Unable to find git and can not run without it, exiting with error"
  exit 1
fi

local homebrew_locations=(
  "/opt/homebrew"
  "/usr/local")
for location in $homebrew_locations; do
  if [[ -d "$location/bin" && -x "$location/bin/brew" ]]; then
    echo "Found existing homebrew directory at '$location', exiting with error"
    exit 1
  fi
done

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
for location in $homebrew_locations; do
  if [[ -d "$location/bin" && -x "$location/bin/brew" ]]; then
    path=("$location/bin" "$location/sbin" $path)
    break
  fi
done

if (( ! $+commands[brew] )); then
  echo "Could not find brew command, exiting with error"
  exit 1
fi

eval "${(@M)${(f)"$(brew shellenv 2> /dev/null)"}:#export HOMEBREW*}"
brew update --force --quiet || error_fn "brew update failed"
chmod -R go-w "$(brew --prefix)/share/zsh" || error_fn "chmod failed"

exit 0
