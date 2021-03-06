#!/bin/sh

current_directory=$( pwd )

#remove spaces
for i in *.shn; do mv "$i" `echo $i | tr ' ' '_'`; done

#remove uppercase
for i in *.[Ss][Hh][Nn]; do mv "$i" `echo $i | tr '[A-Z]' '[a-z]'`; done

#Rip with Mplayer / encode with LAME
for i in *.shn ; do mplayer -vo null -vc null -af resample=44100 -ao pcm:waveheader $i && lame -b 192 -m s audiodump.wav -o $i; done

#convert file names
for i in *.shn; do mv "$i" "`basename "$i" .shn`.mp3"; done

rm audiodump.wav
