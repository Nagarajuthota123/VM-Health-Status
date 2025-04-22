#!/bin/bash

# Function to calculate CPU utilization
check_cpu_utilization() {
  # Get the CPU idle percentage from top command
  idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
  cpu_utilization=$(echo "100 - $idle" | bc)
  echo "$cpu_utilization"
}

# Function to calculate memory utilization
check_memory_utilization() {
  # Get memory usage from free command
  mem_used=$(free | grep Mem | awk '{print $3}')
  mem_total=$(free | grep Mem | awk '{print $2}')
  mem_utilization=$(echo "scale=2; ($mem_used / $mem_total) * 100" | bc)
  echo "$mem_utilization"
}

# Function to calculate disk utilization
check_disk_utilization() {
  # Get disk usage from df command
  disk_utilization=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
  echo "$disk_utilization"
}

# Check health status
cpu=$(check_cpu_utilization)
memory=$(check_memory_utilization)
disk=$(check_disk_utilization)

health_status="Healthy"
reason=""

if (( $(echo "$cpu > 60" | bc -l) )); then
  health_status="Not Healthy"
  reason+="CPU utilization: ${cpu}% (exceeds 60%)\n"
fi

if (( $(echo "$memory > 60" | bc -l) )); then
  health_status="Not Healthy"
  reason+="Memory utilization: ${memory}% (exceeds 60%)\n"
fi

if (( disk > 60 )); then
  health_status="Not Healthy"
  reason+="Disk space utilization: ${disk}% (exceeds 60%)\n"
fi

# Handle --explain argument
if [[ $1 == "--explain" ]]; then
  echo -e "Health Status: $health_status"
  if [[ $health_status == "Not Healthy" ]]; then
    echo -e "Reason:\n$reason"
  fi
else
  echo "Health Status: $health_status"
fi
