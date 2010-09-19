#!/usr/bin/python
import sys
import re

def format_lint_line(line):
 line = line.replace('<p>', '\n')
 line = line.replace('<br>', '\n')
 line = line.replace('&nbsp;', ' ')
 line = line.replace('<div>', '\n');
 return line

def remove_html_tags(data):
 p = re.compile(r'<.*?>')
 return p.sub('', data)

for line in sys.stdin:
 print remove_html_tags(format_lint_line(line)),
