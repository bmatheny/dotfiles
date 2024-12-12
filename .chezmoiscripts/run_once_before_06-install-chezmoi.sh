#!/usr/bin/env zsh
# vim: set ft=zsh:

if [[ "$(uname)" != Darwin ]]; then
  sh -c "$(curl -fsLS get.chezmoi.io)"
  exit 0
fi

local homebrew_locations=(
  "/opt/homebrew"
  "/usr/local")
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

brew install chezmoi

exit 0
