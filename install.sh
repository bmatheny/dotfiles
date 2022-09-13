#!/usr/bin/env zsh
# vim: set ft=zsh:

set -x

# TODO: Look at morganson.tools and connect that to this install.sh
# TODO: Should this install homebrew and install chezmoi from homebrew?
# TODO: Some zsh snippits would be helpful to pull into one file

CHEZMOI_CMD="chezmoi"
: "${DOTFILES_REPO:=bmatheny/dotfiles.git}"

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

if [[ -d ".local/share/chezmoi/.git" ]]; then
  "$CHEZMOI_CMD" update --apply --verbose
else
	"$CHEZMOI_CMD" init --apply $GIT_REPO || error_fn "Failed to initialize dotfiles from git repository '$GIT_REPO'"
fi

# if [[ ! -d src/third-party/homebrew ]]; then
#   cd src/third-party
#   git clone https://github.com/Homebrew/brew homebrew
#   eval "$(homebrew/bin/brew shellenv)"
#   brew update --force --quiet
#   chmod -R go-w "$(brew --prefix)/share/zsh"
# else
#   eval "$(src/third-party/homebrew/bin/brew shellenv)"
# fi

exit 0
