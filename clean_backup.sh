#!/bin/bash

workdir="/home/shflte/.klei/DoNotStarveTogether"

# Change directory to world_backup
cd "$workdir/world_backup"

# Loop through all directories in world_backup
for dir in */; do
	# Check if directory name matches YYYYMMDD pattern
	if [[ $dir =~ ^[0-9]{8}/$ ]]; then
		# Get directory creation date in seconds since Unix epoch
		dir_date=$(date -d "${dir:0:8}" +%s)
		# Get current date in seconds since Unix epoch
		current_date=$(date +%s)
		# Calculate difference in seconds between current date and directory creation date
		date_diff=$(( current_date - dir_date ))
		# Calculate number of days difference
		days_diff=$(( date_diff / 86400 ))
		# Check if directory is older than 30 days and doesn't have a message in its name
		if [[ $days_diff -gt 30 && ! $dir =~ [0-9]{8}_.* ]]; then
			echo "Removing backup directory $dir"
			# Remove directory and its contents recursively
			rm -rf "$dir"
		fi
	fi
done

echo "Cleanup complete."

