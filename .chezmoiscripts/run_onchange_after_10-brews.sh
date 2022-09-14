#!/usr/bin/env zsh
# vim: set ft=zsh:

# TODO: 1password-cli
# TODO: ruby-build rbenv?

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
}

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

(( $+commands[brew] )) || error_fn "Could not find homebrew"
(( $+commands[chezmoi] )) || error_fn "Could not find chezmoi"
(( $+commands[shyaml] )) || error_fn "Could not find shyaml"

packages="$(chezmoi source-path)/packages.yaml"

[[ -f $packages ]] || error_fn "Could not find packages file '${packages}'"

for group in $(cat "${packages}" | shyaml keys brew); do
  brewfile=""
  for brew in $(cat "${packages}" | shyaml get-values "brew.${group}"); do
    brewfile="${brewfile}\nbrew \"${brew}\""
  done
  echo $brewfile | brew bundle --quiet --file=-
done

exit 0

