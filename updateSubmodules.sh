#!/bin/sh

# Where is this running from?
BASE=$PWD;

function current_branch () {
  ref=$(git symbolic-ref HEAD 2> /dev/null)  || return
  echo ${ref#refs/heads/}
}

for gitdir in `find . -name .git|grep -v command-t|sed 's/.git//g'`; do
	BASEGIT=`basename $gitdir`
	if [ "$BASEGIT" == "." ]; then
		echo "Skipping $BASEGIT";
	else
		echo "Evaluating $BASEGIT";
		cd $gitdir;
    git pull origin $(current_branch);
		cd $BASE;
	fi
done
