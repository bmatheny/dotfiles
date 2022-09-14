#!/usr/bin/env zsh
# vim: set ft=zsh:

# Usage: checksum file
# Prints sha or default value

function usage {
  echo "Usage: $0 file $1"
  exit 1
}

file=$1
if [ -z "$file" ]; then
  usage
fi

(( $+commands[shasum] )) || usage "Failed to find shasum program"

if [ -f "$file" -a -r "$file" ]; then
  shasum -a 256 "$file" | sed 's/ .*//'
else
  echo "NO SUCH FILE"
fi

exit 0
