#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $HOME

if [[ ! -d src/third-party ]]; then
  mkdir -p src/third-party
fi

if [[ ! -d src/third-party/homebrew ]]; then
  cd src/third-party
  git clone https://github.com/Homebrew/brew homebrew
  eval "$(homebrew/bin/brew shellenv)"
  brew update --force --quiet
  chmod -R go-w "$(brew --prefix)/share/zsh"
  cd $HOME
else
  eval "$(src/third-party/homebrew/bin/brew shellenv)"
fi

if [[ ! -d tmp ]]; then
        mkdir tmp;
fi

if [[ ! -d bin ]]; then
        mkdir bin;
fi

cd $SCRIPT_DIR

git submodule update --init --recursive

echo 'Now run: rake setup'
