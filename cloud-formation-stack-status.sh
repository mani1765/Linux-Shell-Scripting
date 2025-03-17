#!/bin/bash

# Configuration
STACK_NAME="my-cloudformation-stack"
REGION="us-east-1"

# Function to check CloudFormation stack status
check_stack_status() {
    stack_status=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --region $REGION --query "Stacks[0].StackStatus" --output text)
    
    if [[ "$stack_status" == "CREATE_COMPLETE" || "$stack_status" == "UPDATE_COMPLETE" ]]; then
        echo "CloudFormation stack $STACK_NAME is in a successful state: $stack_status."
    else
        echo "CloudFormation stack $STACK_NAME is in a failure state: $stack_status."
    fi
}

# Run the status check
check_stack_status
