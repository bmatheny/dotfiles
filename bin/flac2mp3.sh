#!/bin/sh

current_directory=$( pwd )

#remove spaces
for i in *.flac; do mv "$i" `echo $i | tr ' ' '_'`; done

#remove uppercase
for i in *.[Ff][Ll][Aa][Cc]; do mv "$i" `echo $i | tr '[A-Z]' '[a-z]'`; done

#Rip with flac / encode with LAME
for i in *.flac ; do rm -f audiodump.wav && flac -d -o audiodump.wav $i && lame -b 256 -m s audiodump.wav -o $i; done

#convert file names
for i in *.flac; do mv "$i" "`basename "$i" .flac`.mp3"; done

rm audiodump.wav
