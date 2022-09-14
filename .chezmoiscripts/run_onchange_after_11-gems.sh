#!/usr/bin/env zsh
# vim: set ft=zsh:

# Note that this uses 'gem' from your environment. So if you
# do nothing, it'll likely be the gem/ruby that was installed
# by homebrew. But if you prefer a different ruby (e.g. rbenv)
# then you should install that and setup the path correctly.

function error_fn {
  echo "Exiting with error: '$1'"
  exit 1
}

if (( ! $+commands[brew] )); then
  homebrew_locations=(
    "${HOME}/homebrew"
    "/usr/local")
  for location in $homebrew_locations; do
    if [[ -d "${location}/bin" && -x "${location}/bin/brew" ]]; then
      eval "$(${location}/bin/brew shellenv)"
      break
    fi
  done
fi

(( $+commands[brew] )) || error_fn "Could not find homebrew"
(( $+commands[chezmoi] )) || error_fn "Could not find chezmoi"
(( $+commands[shyaml] )) || error_fn "Could not find shyaml"

packages="$(chezmoi source-path)/packages.yaml"

[[ -f "${packages}" ]] || error_fn "Could not find packages file '${packages}'"

function gem_install {
  gem="$1"
  if gem info --installed --silent "${gem}"; then
    gem update --silent "${gem}" || error_fn "Failed to update gem '$gem'"
  else
    gem install --silent "${gem}" || error_fn "Failed to install gem '$gem'"
  fi
}

for gem in $(cat "${packages}" | shyaml get-values gems | tr "\n" " "); do
  gem_install "${gem}"
done

exit 0
