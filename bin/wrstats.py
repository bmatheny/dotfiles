#!/usr/bin/env python

## wrstats.py, v0.1
## Copyright (C) 2003 Gary Benson <gary@inauspicious.org>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

"""Read statistics files produced by Workrave."""

import os
import time

def __mktime(day, mon, year, hour, min):
    return int(time.mktime(time.strptime("%04d-%02d-%02d %02d:%02d:00" % (
        year + 1900, mon, day, hour, min), "%Y-%m-%d %H:%M:%S")))

def readfile(file = None):
    """Read statistics files produced by Workrave.

    If supplied, the single argument can be either a file pointer or a
    filename; if omitted then the file ~/.workrave/historystats will
    be read.
    """
    if file is None:
        file = os.path.join(os.environ["HOME"], ".workrave", "historystats")
    if not hasattr(file, "readline"):
        file = open(file, "r")

    if file.readline() != "WorkRaveStats 4\n":
        raise ValueError, "file format not recognised"

    rows = []
    while 1:
        line = file.readline()
        if not line:
            break
        if not line.startswith("D "):
            raise ValueError, "bad line %s" % repr(line)
        (s_day, s_mon, s_year, s_hour, s_min,
         e_day, e_mon, e_year, e_hour, e_min) = map(int, line[2:-1].split())
        s_time = __mktime(s_day, s_mon, s_year, s_hour, s_min)
        e_time = __mktime(e_day, e_mon, e_year, e_hour, e_min)
        rows.append(["%04d-%02d-%02d" % (s_year + 1900, s_mon, s_day),
                     s_time, e_time])

        for i in range(3):
            line = file.readline()
            if not line.startswith("B %d 7 " % i):
                raise ValueError, "bad line %s" % repr(line)
            (prompted, taken, natural_taken, skipped, postponed,
             unique_breaks, total_overdue) = map(int, line[6:-2].split())
            if i != 2:
                rows[-1].extend([taken, natural_taken])

        line = file.readline()
        if not line.startswith("m 6 "):
            raise ValueError, "bad line %s" % repr(line)
        rows[-1].extend(map(int, line[4:-2].split()))

    return rows

if __name__ == "__main__":
    # read the default file and print it out in some gnuplottable form
    print """\
# Columns:
#   1. Start day
#   2. Start time (seconds since epoch)
#   3. Finish time (seconds since epoch)
#   4. Number of forced micropauses
#   5. Number of natural micropauses
#   6. Number of forced restbreaks
#   7. Number of natural restbreaks
#   8. Active time (seconds)
#   9. Mouse movement (pixels)
#  10. 'Effective' mouse movement (pixels)
#  11. Mouse movement time (seconds)
#  12. Number of mousebutton clicks
#  13. Number of keystrokes"""
    for row in readfile():
        print " ".join(map(str, row))
