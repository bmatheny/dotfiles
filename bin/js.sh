#!/bin/sh

export PATH=$PATH:$HOME/bin

PLATFORM=`/bin/uname -i`
JS_NAME="js-$PLATFORM"
JS_PATH=`/usr/bin/which $JS_NAME 2>&1|head -1|awk '{print $1}'`

if [ ! -x $JS_PATH ]; then
	echo "No $JS_NAME found. Exiting.";
	exit 1;
fi;

if [ $# -ne 2 ]; then
	echo "You must specify the code to be checked";
	exit;
fi;

exec $JS_PATH $1 "$2"
