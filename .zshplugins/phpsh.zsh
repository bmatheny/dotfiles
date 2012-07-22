# After running python setup.py install --prefix=~, need an updated path
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:~/lib/python2.7/site-packages

# Also need to modify bin/phpsh to use /usr/bin/env python instead of /usr/bin/python
