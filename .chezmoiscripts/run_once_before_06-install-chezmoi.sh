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
else
  sh -c "$(curl -fsLS get.chezmoi.io)"
fi


exit 0
