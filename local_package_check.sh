#!/bin/bash
# Author: Jeremy Peters
# Version: 1.0

# Check if any arguments are provided
if [ "$#" -lt 1 ]; then
    echo '{"error": "Provide at least one package name as an argument."}'
    exit 1
fi

# Initialize JSON output
output="{"

# Loop through all arguments (package names)
for pkg in "$@"; do
    if rpm -q "$pkg" &> /dev/null; then
        output+="\"$pkg\": true,"
    else
        output+="\"$pkg\": false,"
    fi
done

# Remove the trailing comma
output=${output%,}

# Close JSON bracket
output+="}"

echo "$output"
