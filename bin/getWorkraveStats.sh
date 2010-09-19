#!/bin/sh

cd /tmp
rm -f workrave.out
rm -f workrave.png
$HOME/bin/workrave-dump.pl > /tmp/workrave.out
$HOME/bin/gnuplot-workrave.sh
rm -f workrave.out
