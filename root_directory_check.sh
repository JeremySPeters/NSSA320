#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo '{"error": "Usage: '$0' <ip_address_or_domain>"}'
    exit 1
fi

# Fetch the webpage content from the root directory
response=$(curl -s "http://$1/")

# Check for directory listing pattern specific to Apache
if [[ $response =~ '<title>Index of /</title>' ]]; then
    echo '{"directory_listing_root": true}'
else
    echo '{"directory_listing_root": false}'
fi
