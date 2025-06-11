#!/bin/bash

# Prompt user to enter services separated by space
read -p "Enter the service names (space-separated): " -a services

# Loop through each service provided by the user
for service in "${services[@]}"; do

    # Check if the service is active
    if ! systemctl is-active --quiet "$service"; then
        echo "$service is down. Restarting..."
        systemctl restart "$service"

        # Check if the restart succeeded
        if systemctl is-active --quiet "$service"; then
            echo "$service restarted successfully."
        else
            echo "Failed to restart $service. Check systemctl status and logs."
        fi
    else
        echo "$service is running."
    fi

done
