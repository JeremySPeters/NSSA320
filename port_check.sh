#!/bin/bash

# Check if there are any arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <comma-separated ports to exclude>"
    exit 1
fi

# Get ports to exclude from the arguments
EXCLUDE_PORTS=$1

# Convert the comma-separated values to a space-separated list
EXCLUDE_PORTS_LIST=$(echo $EXCLUDE_PORTS | tr ',' ' ')

# Function to check if a value is in an array
contains() {
    local value="$1"
    shift
    for excluded_port; do
        [[ "$excluded_port" == "$value" ]] && return 0
    done
    return 1
}

# Check all listening TCP ports
netstat -tuln | grep LISTEN | awk '{print $4}' | awk -F':' '{print $NF}' | while read -r port; do
    if ! contains "$port" "${EXCLUDE_PORTS_LIST[@]}"; then
        echo "Port $port is open."
    fi
done
