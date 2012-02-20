#!/bin/sh

# Where is this running from?
BASE=$PWD;

for gitdir in `find . -name .git|grep -v command-t|sed 's/.git//g'`; do
	BASEGIT=`basename $gitdir`
	if [ "$BASEGIT" == "." ]; then
		echo "Skipping $BASEGIT";
	else
		echo "Evaluating $BASEGIT";
		cd $gitdir;
		git co master;
		git pull;
		cd $BASE;
	fi
done
