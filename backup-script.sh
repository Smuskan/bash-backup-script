#!/bin/bash

# Ensure the correct number of arguments are passed (2 arguments required)
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

# Verify that both arguments are valid directories
if [[ ! -d "$1" || ! -d "$2" ]]; then
  echo "Error: One or both of the provided paths are not valid directories."
  exit 1
fi

# Assign source and destination directories from arguments
sourceDir="$1"
destDir="$2"

# Display the source and destination directories
echo "Source Directory: $sourceDir"
echo "Destination Directory: $destDir"

# Generate the current timestamp for backup filename
timestamp=$(date +%s)

# Create the backup filename with timestamp
backupFile="backup-$timestamp.tar.gz"

# Store the current working directory for later use
currentDir=$(pwd)

# Move to the destination directory to store the absolute path
cd "$destDir"
destAbsPath=$(pwd)

# Return to the original directory and move to the source directory for processing
cd "$currentDir"
cd "$sourceDir"

# Calculate the timestamp for 24 hours ago
previousDay=$(($timestamp - 86400)) # 86400 seconds = 24 hours

# Initialize an array to hold files modified within the last 24 hours
declare -a recentFiles=()

# Loop through the files in the source directory and check if they were modified in the last 24 hours
for file in *; do
  if [[ -f "$file" && $(date -r "$file" +%s) -gt $previousDay ]]; then
    recentFiles+=("$file")
  fi
done

# Check if there are files to backup
if [[ ${#recentFiles[@]} -eq 0 ]]; then
  echo "No files modified in the last 24 hours to back up."
  exit 0
fi

# Create the compressed archive with the filtered files
tar -czvf "$backupFile" "${recentFiles[@]}"

# Move the created backup file to the destination directory
mv "$backupFile" "$destAbsPath"

echo "Backup successful! File '$backupFile' moved to '$destAbsPath'."
