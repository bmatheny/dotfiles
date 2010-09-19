#!/usr/bin/gnuplot

set title "Workrave"
set ylabel "Keystrokes"
set timefmt "%Y%m%d%H%M"
set format x "%Y-%m-%d"
set xtics rotate
set xdata time
set key off
set tmargin 4
set bmargin 8
set lmargin 12
set rmargin 8
set style fill solid 1.0 noborder
set terminal png transparent medium size 440,330
set output "workrave.png"
plot "workrave.out" using 1:28 with boxes
