#!/bin/bash

# Check if there are any arguments
if [ "$#" -ne 1 ]; then
    echo '{"error": "Usage: '$0' <comma-separated ports to exclude>"}'
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

# Array to store the open ports
open_ports=()

# Check all listening TCP ports
netstat -tuln | grep LISTEN | awk '{print $4}' | awk -F':' '{print $NF}' | while read -r port; do
    if ! contains "$port" "${EXCLUDE_PORTS_LIST[@]}"; then
        open_ports+=("$port")
    fi
done

# Construct JSON output
json_output="{\"open_ports\": ["
for port in "${open_ports[@]}"; do
    json_output+="\"$port\","
done

# Remove the last comma and close the JSON
json_output=${json_output%,}
json_output+="]}"

# Print the JSON output
echo "$json_output"
