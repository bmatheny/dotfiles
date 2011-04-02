#!/bin/sh

export PATH=$PATH:$HOME/bin

if [ -x "/bin/uname" ]; then
	PLATFORM=`/bin/uname -i`;
elif [ -x "/usr/local/bin/uname" ]; then
	PLATFORM=`/usr/local/bin/uname -i`;
else
	echo "No uname found";
	exit 1;
fi

JS_NAME="js-$PLATFORM"
JS_PATH=`/usr/bin/which $JS_NAME 2>&1|head -1|awk '{print $1}'`

if [[ -n "$JS_PATH" || ! -x $JS_PATH ]]; then
	if [ -x "/usr/local/bin/js" ]; then
		JS_PATH="/usr/local/bin/js";
	else
		echo "No $JS_NAME found. Exiting.";
		exit 1;
	fi
fi;

if [ $# -ne 2 ]; then
	echo "You must specify the code to be checked";
	exit;
fi;

exec $JS_PATH $1 "$2"
