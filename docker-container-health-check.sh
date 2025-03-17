#!/bin/bash

# List of containers to monitor
containers=("nginx" "mysql" "redis")

# Function to check container status
check_container_status() {
    for container in "${containers[@]}"; do
        status=$(docker inspect --format '{{.State.Status}}' $container)
        if [ "$status" != "running" ]; then
            echo "Container $container is not running. Restarting..."
            docker restart $container
        else
            echo "Container $container is running."
        fi
    done
}

# Run the container status check
check_container_status
