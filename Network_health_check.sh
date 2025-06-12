#!/bin/bash

# List all network interfaces
interfaces=($(ip -o link show | awk -F': ' '{print $2}'))

# Display interfaces
echo "Available network interfaces:"
for i in "${!interfaces[@]}"; do
    echo "$((i+1)). ${interfaces[$i]}"
done

# Ask user to select one
read -p "Enter the number of the interface to check: " choice

# Validate input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#interfaces[@]} )); then
    echo "Invalid choice."
    exit 1
fi

# Get selected interface
selected_iface="${interfaces[$((choice-1))]}"
echo "Checking network health for interface: $selected_iface"

# Check if interface is up
state=$(cat /sys/class/net/"$selected_iface"/operstate)

echo "Interface state: $state"

# Get IP address
ip_address=$(ip addr show "$selected_iface" | awk '/inet / {print $2}' | cut -d/ -f1)

if [ -n "$ip_address" ]; then
    echo "IP Address: $ip_address"
else
    echo "No IP address assigned."
fi

# Test connectivity (pinging 8.8.8.8 as a basic health check)
echo "Pinging 8.8.8.8 to check connectivity..."
if ping -I "$selected_iface" -c 4 -q 8.8.8.8 > /dev/null 2>&1; then
    echo "Network connectivity: ✅ OK"
else
    echo "Network connectivity: ❌ Failed"
fi
