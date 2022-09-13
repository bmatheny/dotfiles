#!/usr/bin/env zsh
# vim: set ft=zsh:

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

shyaml get-values :brew

mydir=${0:a:h}
file="${mydir}/config.yaml"

for b in $(cat .chezmoiscripts/config.yaml | shyaml keys brew); do cat .chezmoiscripts/config.yaml | shyaml get-values brew.$b; done

exit 1

# Install libraries
brew bundle --file=- <<EOF
brew "gettext"
brew "gmp"
brew "ncurses"
brew "pcre"
brew "pcre2"
EOF

# Install databases
brew bundle --file=- <<EOF
brew "berkeley-db"
brew "gdbm"
brew "sqlite"
EOF

# Ensure some nice to haves
brew bundle --file=- <<EOF
brew "ack"
brew "bat"
brew "colordiff"
brew "htop"
brew "nb"
brew "nmap"
brew "pandoc"
brew "telnet"
brew "unzip"
brew "watch"
brew "w3m"
brew "xz"
brew "zstd"
EOF

# foo="1password-cli"
# bar="ruby-build rbenv"
