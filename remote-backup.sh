#!/bin/bash

# Configuration
SOURCE_DIR="/home/user/data"
BACKUP_DIR="/backup"
REMOTE_SERVER="user@remote-server:/backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/backup_${TIMESTAMP}.tar.gz"

# Function to create a local backup
create_local_backup() {
    echo "Creating local backup of $SOURCE_DIR..."
    tar -czf $BACKUP_FILE $SOURCE_DIR
    echo "Backup created: $BACKUP_FILE"
}

# Function to copy backup to remote server
copy_backup_to_remote() {
    echo "Copying backup to remote server..."
    scp $BACKUP_FILE $REMOTE_SERVER
    if [ $? -eq 0 ]; then
        echo "Backup successfully copied to remote server."
    else
        echo "Error occurred during remote backup."
    fi
}

# Run the backup functions
create_local_backup
copy_backup_to_remote
