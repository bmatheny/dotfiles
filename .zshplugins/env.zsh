#-----------------------------------------------------------------------------
# Environment Variables
#-----------------------------------------------------------------------------

export WORKSPACE=~/src/workspace

# List of suffixes to ignore when performing filename completion
export FIGNORE=".svn:.o:~"

# Needed for our custom version of 'less'
export MYVIMDIR="$HOME/.vim/"

# Use less as our pager
export PAGER=less
export LESS=-R

# vim is our editor of choice
export EDITOR=vim

# Set HOST to something we know
export HOST=`hostname`

# Be sure to use SSH when connecting to repository
export CVS_RSH='ssh'

# Because UTF-8 is all the rage, set everything to POSIX
for lc in LANG LC_CTYPE LC_NUMERIC LC_TIME	\
	  LC_COLLATE LC_MONETARY LC_MESSAGES	\
	  LC_PAPER LC_NAME LC_ADDRESS 		\
	  LC_TELEPHONE LC_MEASUREMENT		\
	  LC_IDENTIFICATION LC_ALL
do
    export $lc=POSIX
done
