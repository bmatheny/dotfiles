#!/usr/bin/env zsh
# vim: set ft=zsh:

# Usage: checksum file or part of file if yaml
# Prints sha or default value

function usage {
  echo "Usage: $0 file key"
  if [[ ! -z "$1" ]]; then
    echo "error was: $1"
  fi
  exit 1
}

file=$1
if [[ -z "$file" ]]; then
  usage
fi

(( $+commands[shasum] )) || usage "Failed to find shasum program"

key=$2
use_yaml=0
# If the user specified a key in the file
if [[ ! -z "$key" ]]; then
  # And we have shyaml installed
  if (( $+commands[shyaml] )); then
    # Then we can use yaml
    use_yaml=1
  fi
fi

if [ -f "$file" -a -r "$file" ]; then
  if [[ $use_yaml -eq 1 ]]; then
    cat "$file" | shyaml -q get-value "$key" | shasum -a 256 | sed 's/ .*//'
  else
    shasum -a 256 "$file" | sed 's/ .*//'
  fi
else
  echo "NO SUCH FILE"
fi

exit 0
