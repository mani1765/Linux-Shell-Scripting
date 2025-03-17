#!/bin/bash

# Configuration
LOG_DIR="/var/log/myapp"
MAX_AGE_DAYS=7

# Function to rotate logs
rotate_logs() {
    echo "Rotating logs in $LOG_DIR..."
    for log_file in $LOG_DIR/*.log; do
        if [ -f "$log_file" ]; then
            timestamp=$(date +"%Y-%m-%d")
            mv $log_file ${log_file}_${timestamp}.log
            gzip ${log_file}_${timestamp}.log
            echo "Log file $log_file rotated and compressed."
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    echo "Deleting logs older than $MAX_AGE_DAYS days..."
    find $LOG_DIR -type f -name "*.log.gz" -mtime +$MAX_AGE_DAYS -exec rm -f {} \;
    echo "Old logs deleted."
}

# Run the log rotation and deletion
rotate_logs
delete_old_logs
