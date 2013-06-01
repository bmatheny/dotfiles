#!/bin/bash

# Where is this running from?
BASE=$PWD;

function current_branch () {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ -z "${ref}" ]; then
    ref="refs/heads/master"
  fi
  echo ${ref#refs/heads/}
}

if [ -z "$USE_PROXYCMD" ]; then
  gitcmd="git"
else
  gitcmd="proxycmd.sh git"
fi

submodules=$(git submodule status --recursive|awk '{print $2}' | grep -v vendor)
set -x
for gitdir in $submodules; do
  BASEGIT=`basename $gitdir`
  if [ ! -f $gitdir/.git ]; then
    $gitcmd submodule init $gitdir;
    $gitcmd submodule update $gitdir;
  else
    $gitcmd pull origin $(current_branch)
  fi
  cd $BASE;
done
