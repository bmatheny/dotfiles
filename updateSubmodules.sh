#!/bin/sh

for i in `find .vim/bundle -name .git|grep -v command-t|sed 's/.git//g'`; do
	cd $i;
	echo "Evaluating `basename $i`"
	git co master;
	git pull;
	cd ../../..;
done
