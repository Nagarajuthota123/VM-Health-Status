#!/bin/bash

read -p "How many users do you want to create? " user_count

for ((i = 1; i <= user_count; i++)); do
    echo "Enter details for user $i:"

    read -p "Username: " username
    read -s -p "Password: " password
    echo

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping..."
    else
        # Create the user
        useradd "$username"

        # Set the password
        echo "$username:$password" | chpasswd

        # Optionally force password change on first login
        chage -d 0 "$username"

        echo "User $username created successfully."
    fi
done
