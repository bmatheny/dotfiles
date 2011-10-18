# Makes it so scp globbing is automatically fixed (turns * into \*)
# Makes it so wget with ampersand in it gets fixed in the same way
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema \
	'[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp)'
