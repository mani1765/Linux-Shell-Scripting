#!/bin/bash

# Configuration
INSTANCE_ID="i-1234567890abcdef0"
REGION="us-east-1"

# Function to start EC2 instance
start_instance() {
    echo "Starting EC2 instance $INSTANCE_ID..."
    aws ec2 start-instances --instance-ids $INSTANCE_ID --region $REGION
    echo "Instance started."
}

# Function to stop EC2 instance
stop_instance() {
    echo "Stopping EC2 instance $INSTANCE_ID..."
    aws ec2 stop-instances --instance-ids $INSTANCE_ID --region $REGION
    echo "Instance stopped."
}

# Function to get EC2 instance status
get_instance_status() {
    status=$(aws ec2 describe-instance-status --instance-ids $INSTANCE_ID --region $REGION --query 'InstanceStatuses[0].InstanceState.Name' --output text)
    echo "Current instance status: $status"
}

# Menu for user interaction
menu() {
    echo "1. Start EC2 Instance"
    echo "2. Stop EC2 Instance"
    echo "3. Get EC2 Instance Status"
    echo "4. Exit"

    read -p "Choose an option: " choice
    case $choice in
        1) start_instance ;;
        2) stop_instance ;;
        3) get_instance_status ;;
        4) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
}

# Run the menu function
menu
