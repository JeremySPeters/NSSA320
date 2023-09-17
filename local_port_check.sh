#!/bin/bash

# Check if there are any arguments
if [ "$#" -lt 1 ]; then
    echo '{"error": "Usage: '$0' <space-separated ports to exclude>"}'
    exit 1
fi

# Convert the arguments to an array
EXCLUDE_PORTS_LIST=("$@")

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
