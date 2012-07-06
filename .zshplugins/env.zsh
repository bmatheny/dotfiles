#-----------------------------------------------------------------------------
# Environment Variables
#-----------------------------------------------------------------------------

export WORKSPACE=~/src/workspace

# List of suffixes to ignore when performing filename completion
export FIGNORE=".svn:.o:~"

# Needed for our custom version of 'less'
export MYVIMDIR="$HOME/.vim/"

# vim is our editor of choice
export EDITOR=vim

# Use less as our pager
export PAGER=less

# Set HOST to something we know
export HOST=`hostname`

# Be sure to use SSH when connecting to repository
export CVS_RSH='ssh'

# Boo.... http://git.661346.n2.nabble.com/quot-git-pull-quot-doesn-t-know-quot-edit-quot-td7276525.html
export GIT_MERGE_AUTOEDIT=no

# Because UTF-8 is all the rage
for lc in LANG LC_CTYPE LC_NUMERIC LC_TIME	\
	  LC_COLLATE LC_MONETARY LC_MESSAGES	\
	  LC_PAPER LC_NAME LC_ADDRESS 		\
	  LC_TELEPHONE LC_MEASUREMENT		\
	  LC_IDENTIFICATION LC_ALL
do
    export $lc=en_US.UTF-8
done
