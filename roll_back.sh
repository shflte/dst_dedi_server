#!/bin/bash

workdir="/home/shflte/.klei/DoNotStarveTogether"

# Parse command-line options
while getopts "s:" opt; do
	case $opt in
		s)
			save_folder="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done

# Find latest backup folder if save_folder is not specified
if [ -z "$save_folder" ]; then
	backup_folder=$(ls -td "$workdir/world_backup"/* | head -n 1)
else
	backup_folder="$workdir/world_backup/$save_folder"
fi

# Check if backup folder exists
if [ ! -d "$backup_folder" ]; then
	echo "Error: backup folder does not exist." >&2
	exit 1
fi

# Delete contents of MyDediServer
rm -rf "$workdir/MyDediServer"/*

# Copy contents of backup folder to MyDediServer
cp -r "$backup_folder"/* "$workdir/MyDediServer/"

