#!/bin/bash

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!"
    exit 1
fi

# Function to create a user and add to the ubuntu group
create_user() {
    read -p "Enter the username: " username

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "Error: User $username already exists."
    else
        read -sp "Enter the password: " password
        echo
        read -p "Enter the Ubuntu group to add user to: " group
        
        # Create the user
        useradd -m -G $group $username

        # Set the password for the user
        echo "$username:$password" | chpasswd
        
        echo "User $username created and added to the $group group."
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter the username to delete: " username
    
    # Check if user exists
    if id "$username" &>/dev/null; then
        userdel -r $username
        echo "User $username deleted."
    else
        echo "Error: User $username does not exist."
    fi
}

# Function to list all users
list_users() {
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
}

# Function to lock a user account
lock_user() {
    read -p "Enter the username to lock: " username
    
    # Check if user exists
    if id "$username" &>/dev/null; then
        usermod -L $username
        echo "User $username has been locked."
    else
        echo "Error: User $username does not exist."
    fi
}

# Function to unlock a user account
unlock_user() {
    read -p "Enter the username to unlock: " username
    
    # Check if user exists
    if id "$username" &>/dev/null; then
        usermod -U $username
        echo "User $username has been unlocked."
    else
        echo "Error: User $username does not exist."
    fi
}

# Function to set expiration for a user account
set_expiration() {
    read -p "Enter the username to set expiration for: " username
    
    # Check if user exists
    if id "$username" &>/dev/null; then
        # Set expiration date to 2 months from today
        expire_date=$(date -d "+2 months" +%Y-%m-%d)
        
        usermod -e $expire_date $username
        echo "Expiration date for user $username is set to $expire_date."
    else
        echo "Error: User $username does not exist."
    fi
}

# Main menu for script options
menu() {
    while true; do
        echo "================================="
        echo "User Management Script"
        echo "1. Create User and Password"
        echo "2. Delete User"
        echo "3. List All Users"
        echo "4. Lock User"
        echo "5. Unlock User"
        echo "6. Set Expiration for User"
        echo "7. Exit"
        echo "================================="
        
        read -p "Choose an option [1-7]: " choice

        case $choice in
            1)
                create_user
                ;;
            2)
                delete_user
                ;;
            3)
                list_users
                ;;
            4)
                lock_user
                ;;
            5)
                unlock_user
                ;;
            6)
                set_expiration
                ;;
            7)
                echo "Exiting script."
                exit 0
                ;;
            *)
                echo "Invalid option. Please choose a valid number [1-7]."
                ;;
        esac
    done
}

# Run the menu function
menu
