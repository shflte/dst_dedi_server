#!/bin/bash

workdir="/home/shflte/.klei/DoNotStarveTogether"

# Parse command-line options
while getopts "d:" opt; do
	case $opt in
		d)
			message="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done

# Create backup folder with current date
backup_folder="$workdir/world_backup/$(date +%Y%m%d)"
if [ ! -z "$message" ]; then
	backup_folder="$workdir/world_backup/$(date +%Y%m%d)_$message"
fi
mkdir -p "$backup_folder"

# Backup MyDediServer to backup folder
cp -r $workdir/MyDediServer/* $backup_folder/

