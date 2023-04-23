#!/bin/bash

# Define the session name
session="dst_server"

# Check if session exists
tmux has-session -t $session 2>/dev/null

if [ "$?" -eq 0 ]; then
	# Session exists, kill it
	tmux kill-session -t $session
fi

# Check for the option
while getopts ":ud" opt; do
	case ${opt} in
		u )
			# Start the server
			tmux new-session -d -s $session -n "Panel 1" "/home/shflte/.klei/DoNotStarveTogether/run_server.sh"
			tmux select-window -t $session:0
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

# Attach to the session
tmux attach -t $session

