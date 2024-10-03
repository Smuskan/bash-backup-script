# Daily Backup Script

A simple Bash script to automate daily backups of files that have been modified in the last 24 hours. The script compresses these files into a timestamped archive and moves the backup file to a destination directory.

## Features

- **Automated Backups**: Automatically identifies files modified within the last 24 hours and creates a compressed archive.
- **Timestamped Archives**: Backup file names are appended with a timestamp to ensure uniqueness.
- **Directory Validation**: Ensures that both source and destination directories are valid before proceeding.
- **Error Handling**: Provides clear error messages for incorrect usage or missing directories.

## Prerequisites

- **Bash**: Ensure you have Bash installed (most Linux/Unix systems come with Bash pre-installed).
- **tar**: The script uses `tar` to compress files into an archive.

## Usage

### 1. Make the Script Executable

After downloading the script, make it executable by running:

```bash
chmod +x daily-backup.sh
