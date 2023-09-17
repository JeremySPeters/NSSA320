#!/bin/bash

# Locations for the Apache config (change these if your setup is different)
CONFIG_FILES=("/etc/apache2/apache2.conf" "/etc/httpd/httpd.conf")

DIRECTORY_LISTING_DISABLED=true

# Check each config file for the "Indexes" option
for CONFIG_FILE in "${CONFIG_FILES[@]}"; do
    if [ -f "$CONFIG_FILE" ]; then
        # If "Indexes" is found without a preceding "-", set DIRECTORY_LISTING_DISABLED to false
        if grep -E '^[[:space:]]*Options[[:space:]]+[^#]*\bIndexes\b' "$CONFIG_FILE" > /dev/null; then
            DIRECTORY_LISTING_DISABLED=false
            break
        fi
    fi
done

# Output the result in JSON format
if $DIRECTORY_LISTING_DISABLED; then
    echo '{"directory_listing_disabled": true}'
else
    echo '{"directory_listing_disabled": false}'
fi
