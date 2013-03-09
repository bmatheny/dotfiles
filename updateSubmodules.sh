#!/bin/sh

# Where is this running from?
BASE=$PWD;

function current_branch () {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ -z "${ref}" ]; then
    ref="refs/heads/master"
  fi
  echo ${ref#refs/heads/}
}

submodules=$(git submodule status --recursive|awk '{print $2}' | grep -v vendor)
for gitdir in $submodules; do
  BASEGIT=`basename $gitdir`
  cd $gitdir;
  echo "Evaluating $BASEGIT in $(current_branch)";
  git checkout $(current_branch);
  git pull
  cd $BASE;
done
