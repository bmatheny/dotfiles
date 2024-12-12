#!/usr/bin/env zsh
# vim: set ft=zsh:

local homebrew_locations=(
  "/opt/homebrew"
  "/usr/local")
for location in $homebrew_locations; do
  if [[ -d "$location/bin" && -x "$location/bin/brew" ]]; then
    path=("$location/bin" "$location/sbin" $path)
    break
  fi
done

if (( $+commands[brew] )); then
  brew install chezmoi
  path=("$(brew --prefix chezmoi)/bin" $path)
else
  sh -c "$(curl -fsLS get.chezmoi.io)"
  path=("$HOME/bin" $path)
fi


exit 0
