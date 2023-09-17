#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo '{"error": "Usage: '$0' <ip_address_or_domain>"}'
    exit 1
fi

# Get the HTTP response code
http_response=$(curl -o /dev/null -s -w "%{http_code}" "http://$1/")

# Check the HTTP response code
if [[ $http_response -eq 403 ]]; then
    echo '{"directory_listing_disabled": true}'
else
    echo '{"directory_listing_disabled": false}'
fi
