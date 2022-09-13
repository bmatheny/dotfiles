#!/usr/bin/env zsh

# For tilde expansion below
set -o magicequalsubst

dirs=(
~/tmp
~/.local/vim/plugged
~/.local/vim/swap
~/.local/vim/undo
~/.config/zsh/after
~/.config/zsh/before
)

for dir in $dirs; do
  mkdir -p "${dir}" && echo "Created directory: ${dir}"
done
