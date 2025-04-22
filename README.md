# Virtual Machine Health

This repository contains a shell script that analyzes the health of an Ubuntu virtual machine based on CPU, memory, and disk space utilization. The health status is determined as follows:
- **Healthy**: If CPU, memory, and disk space utilization are all below 60%.
- **Not Healthy**: If any of CPU, memory, or disk space utilization exceeds 60%.

The script also supports a command-line argument `--explain`, which provides the reason for the determined health status along with the status itself.

## Features

1. **Health Check**: Checks the utilization of CPU, memory, and disk space.
2. **Command-Line Argument**: 
   - `--explain`: Explains the reason for the health status.
3. **Target Platform**: Ubuntu virtual machines.

## Script Details

### Steps Performed by the Script
1. **CPU Utilization**: Calculates the CPU usage as a percentage.
2. **Memory Utilization**: Calculates the memory usage as a percentage.
3. **Disk Space Utilization**: Calculates the disk space usage as a percentage.
4. **Health Status**: 
   - If all the above metrics are below 60%, the VM is declared **Healthy**.
   - If any metric exceeds 60%, the VM is declared **Not Healthy**.
5. **Explanations**: If the `--explain` argument is passed, the script outputs the health status along with the specific metric(s) that caused the VM to be declared **Not Healthy**.

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/Nagarajuthota123/virtual-machine-health.git
   ```
2. Navigate to the repository directory:
   ```bash
   cd virtual-machine-health
   ```
3. Make the script executable:
   ```bash
   chmod +x vm_health_check.sh
   ```
4. Run the script:
   - Without explanation:
     ```bash
     ./vm_health_check.sh
     ```
   - With explanation:
     ```bash
     ./vm_health_check.sh --explain
     ```

## Example Output
- **Healthy VM**:
  ```
  Health Status: Healthy
  ```
- **Not Healthy VM** (with `--explain`):
  ```
  Health Status: Not Healthy
  Reason: CPU usage is 75%, Memory usage is 65%.
  ```

## Requirements
- Ubuntu operating system.
- Bash shell.

