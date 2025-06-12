
#!/bin/bash
# filepath: scripts/memory_cpu_report.sh

# Function to generate CPU usage report
generate_cpu_report() {
  echo "=== CPU Usage Report ==="
  # Get CPU usage using top command
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  echo "CPU Usage: $cpu_usage%"
  if (( $(echo "$cpu_usage > 80" | bc -l) )); then
    echo "Warning: High CPU usage detected!"
  else
    echo "CPU usage is within normal limits."
  fi
  echo ""
}

# Function to generate Memory usage report
generate_memory_report() {
  echo "=== Memory Usage Report ==="
  # Get memory usage using free command
  total_memory=$(free -m | awk '/^Mem:/ {print $2}')
  used_memory=$(free -m | awk '/^Mem:/ {print $3}')
  memory_usage=$(echo "scale=2; ($used_memory/$total_memory)*100" | bc)
  echo "Total Memory: ${total_memory}MB"
  echo "Used Memory: ${used_memory}MB"
  echo "Memory Usage: ${memory_usage}%"
  if (( $(echo "$memory_usage > 80" | bc -l) )); then
    echo "Warning: High memory usage detected!"
  else
    echo "Memory usage is within normal limits."
  fi
  echo ""
}
