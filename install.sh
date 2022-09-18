#!/usr/bin/env zsh
# vim: set ft=zsh:

set -x

# TODO: Should this install homebrew and install chezmoi from homebrew?
# TODO: Some zsh snippits would be helpful to pull into one file

CHEZMOI_CMD="chezmoi"
: "${GIT_REPO:=bmatheny/dotfiles.git}"

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
}

if (( ! $+commands[chezmoi] )); then
  bin_dir="$HOME/.local/bin"
  error_string="Could not install chezmoi using"
  CHEZMOI_CMD="$bin_dir/chezmoi"
  if (( $+commands[curl] )); then
    sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b "$bin_dir" || error_fn "$error_string curl"
  elif (( $+commands[wget] )); then
    sh -c "$(wget -qO- https://chezmoi.io/get)" -- -b "$bin_dir" || error_fn "$error_string wget"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
fi

if [[ -d "$HOME/.local/share/chezmoi/.git" ]]; then
  "$CHEZMOI_CMD" update --apply --verbose || error_fn "Failed to chezmoi update --apply"
  exit 0
else
  "$CHEZMOI_CMD" init --apply $GIT_REPO
  if [ $? -ne 0 ]; then
    echo "Non-zero exit code, recommend running 'chezmoi apply' to address"
    exit 1
  else
    echo "Success!"
    exit 0
  fi
fi

exit 1
