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
