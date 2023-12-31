#!/bin/bash
# Author: Jeremy Peters
# Version: 1.0

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo '{"error": "Usage: '$0' <ip_address_or_domain>"}' | jq .
    exit 1
fi

# Fetch the server header
server_header=$(curl -sI "http://$1" | grep "Server:")

# Check and display the server header in JSON format
if [ -z "$server_header" ]; then
    echo '{"server_header_found": false}' | jq .
else
    header_value=$(echo "$server_header" | sed 's/Server: //' | tr -d '\r')
    jq -n --arg hval "$header_value" '{"server_header_found": true, "header_value": $hval}'
fi
