function svndiff () {
	svn diff $@ | colordiff;
}
