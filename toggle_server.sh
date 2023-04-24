
session="dst_server"

# Check if session exists
tmux has-session -t $session 2>/dev/null

if [ "$?" -ne 0 ]; then
	# 如果 session 不存在，就建立一個
	tmux new-session -d -s $session -n "Panel 1"
fi

# Default timeout value
timeout=60

# Parse options
while getopts ":udt:" opt; do
	case ${opt} in
		u )
			# Start the server
			tmux new-window -t $session: -n "Panel 1" "/home/shflte/.klei/DoNotStarveTogether/run_server.sh"
			tmux split-window -h -p 50 -t $session:0
			;;
		d )
			# Stop the server
			tmux send-keys -t $session "c_shutdown()" Enter
			;;

		\? )
			echo "Invalid option: -$OPTARG" 1>&2
			exit 1
			;;
		: )
			echo "Option -$OPTARG requires an argument." 1>&2
			exit 1
			;;
	esac
done
