#!/bin/bash

# Get the current crontab into a temp file
temp_cron=$(mktemp)

# Save current crontab to the temp file
crontab -l > "$temp_cron" 2>/dev/null

# Check if crontab is empty
if [ ! -s "$temp_cron" ]; then
    echo "No cron jobs found for the current user."
    exit 0
fi

# Show the cron jobs with line numbers
echo "Current cron jobs:"
nl -w2 -s'. ' "$temp_cron"

# Ask the user to enter the job number to delete
echo
read -p "Enter the number of the cron job you want to delete: " job_number

# Validate input
if ! [[ "$job_number" =~ ^[0-9]+$ ]]; then
    echo "Invalid input: Not a number."
    rm "$temp_cron"
    exit 1
fi

# Delete the selected line and save the updated crontab
sed "${job_number}d" "$temp_cron" | crontab -

# Clean up
rm "$temp_cron"

echo "Cron job #$job_number has been deleted."
