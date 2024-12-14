#!/usr/bin/env zsh

# For tilde expansion below
set -o magicequalsubst

dirs=(
~/tmp
~/.cache/vim/plugs
~/.local/state/vim/swap
~/.local/state/vim/undo
~/.config/zsh/after
~/.config/zsh/before
~/.config/bmatheny
~/.tmux/plugins
~/.ssh/
)

for dir in $dirs; do
  mkdir -p "${dir}" && echo "Created directory: ${dir}"
done
