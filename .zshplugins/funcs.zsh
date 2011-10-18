unalias ll
function ll () {
	ls -l "$@" | egrep "^d" ;
	ls -lXB "$@" 2>&-| egrep -v "^d|total ";
}

# OSX Only. Use like:
# openTabAndDo "cd ~/tmp" "screen vim +NERDTree"
function openTabAndDo () {
	local writes=""
	for i; do
		writes="${writes}write text \"${i}\""
	done
	osascript <<EOF
      tell application "iTerm"
        set current_terminal to current terminal
        tell current_terminal
          launch session "Default Session"
          set current_session to current session
          tell current_session
${writes}
          end tell
        end tell
      end tell
EOF
}

# Find and Edit a file
function fe () {

	read -r -d '' USAGE <<- 'EOT'
	Usage: findEd [-p path -m max_files -r] filename
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
