# Find and Edit a file
function fe () {

	read -r -d '' USAGE <<- 'EOT'
	Usage: fe [-p path -m max_files -r] filename
	\t-p path to start search in (defaults to .)
	\t-m max number of files in match list to open
	\t-r is regex
	EOT

	local -A Args
	local maxfiles regex fpath filespec filecmd Files
	maxfiles=2
	regex=0
	fpath="."
	Files=()

	zparseopts -A Args -D -K -E p: m: r
	if (( ${+Args[-m]} != 0 )); then
		maxfiles=$Args[-m]
	fi

	if (( ${+Args[-r]} != 0 )); then
		regex=1
	fi

	if (( ${+Args[-p]} != 0 )); then
		fpath=$Args[-p]
	fi

	if [ "$#@" -ne 1 ]; then
		echo $USAGE
		return
	fi

	filespec="$1"
	if (( $regex == 1 )); then
		filecmd=$(ack -g $filespec $fpath | head -n $maxfiles)
	else
		filecmd=$(find $fpath -type f -name $filespec | head -n $maxfiles)
	fi
	Files=(${(f)filecmd})
	if (( ${#Files} == 0 )); then
		echo "No files found from $fpath named $filespec"
		return
	fi

	vim "${Files[@]}"
}
