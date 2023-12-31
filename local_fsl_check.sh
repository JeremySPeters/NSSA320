#!/bin/bash
# Author: Jeremy Peters
# Version: 1.0

CONFIG_FILES=("/etc/httpd/httpd.conf" "/etc/httpd/conf.d/*")

FOLLOWSYMLINKS_FOUND=false

# Check each config file for the "FollowSymLinks" option
for CONFIG_FILE in "${CONFIG_FILES[@]}"; do
    if [ -e "$CONFIG_FILE" ]; then
        if grep -E '^[[:space:]]*Options[[:space:]]+[^#]*\bFollowSymLinks\b' "$CONFIG_FILE" > /dev/null; then
            FOLLOWSYMLINKS_FOUND=true
            break
        fi
    fi
done

# Output the result in JSON format
if $FOLLOWSYMLINKS_FOUND; then
    echo '{"followsymlinks_enabled": true}'
else
    echo '{"followsymlinks_enabled": false}'
fi
