#!/bin/bash

# Thresholds
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
CPU_THRESHOLD=80

# Function to check disk usage
check_disk_usage() {
    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        echo "Warning: Disk usage is ${disk_usage}% (threshold: ${DISK_THRESHOLD}%)"
    else
        echo "Disk usage is under control at ${disk_usage}%."
    fi
}

# Function to check memory usage
check_memory_usage() {
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if [ "$(echo "$memory_usage > $MEMORY_THRESHOLD" | bc)" -eq 1 ]; then
        echo "Warning: Memory usage is ${memory_usage}% (threshold: ${MEMORY_THRESHOLD}%)"
    else
        echo "Memory usage is under control at ${memory_usage}%."
    fi
}

# Function to check CPU usage
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if [ "$(echo "$cpu_usage > $CPU_THRESHOLD" | bc)" -eq 1 ]; then
        echo "Warning: CPU usage is ${cpu_usage}% (threshold: ${CPU_THRESHOLD}%)"
    else
        echo "CPU usage is under control at ${cpu_usage}%. "
    fi
}

# Main function to perform health checks
perform_health_check() {
    echo "Performing system health check..."
    check_disk_usage
    check_memory_usage
    check_cpu_usage
}

# Run health check
perform_health_check
