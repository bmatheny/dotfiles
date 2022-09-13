#!/usr/bin/env zsh
# vim: set ft=zsh:

function gem_install {
  brew gem install $1 --homebrew-ruby
}

cd $HOME

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

if (( ! $+commands[brew] )); then
  echo "Could not find homebrew, exiting"
  exit 1
fi

brew install brew-gem

gem_install "bundler"
gem_install "cheat"
gem_install "chronic"
gem_install "chronic_duration"
gem_install "facter"
gem_install "github-markup"
gem_install "jekyll"
gem_install "jeweler"
gem_install "kramdown"
gem_install "mustache"
gem_install "pry"
gem_install "rake"
gem_install "redcarpet"
gem_install "rspec"
gem_install "terminal-table"
gem_install "thor"
gem_install "yard"
