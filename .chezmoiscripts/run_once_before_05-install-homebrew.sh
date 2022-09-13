#!/usr/bin/env zsh
# vim: set ft=zsh:

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
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

if [[ -d "homebrew" ]]; then
  echo "Found existing homebrew directory at $HOME/homebrew, exiting with error"
  echo "Remove this directory if you want to use this script"
  exit 1
fi

git clone https://github.com/Homebrew/brew homebrew || error_fn "git clone failed"
eval "$(./homebrew/bin/brew shellenv)"
brew update --force --quiet || error_fn "brew update failed"
chmod -R go-w "$(brew --prefix)/share/zsh" || error_fn "chmod failed"

# This is a pre-requisite for most of the other scripts used for managing software
brew install "shyaml"

exit 0
