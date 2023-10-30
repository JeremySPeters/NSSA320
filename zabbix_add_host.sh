#!/bin/bash
# Author: Jeremy Peters

# Check if the required arguments are provided
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 <hostname> <host_ip> <api_ip> <template_id> <group_id> <auth_token>"
  exit 1
fi

# Extract arguments
HOSTNAME="$1"
HOST_IP="$2"
API_IP="$3"
TEMPLATE_ID="$4"
GROUP_ID="$5"
AUTH_TOKEN="$6"

# Construct the API URL
API_URL="http://${API_IP}:10051/api_jsonrpc.php"

# Construct the JSON request
JSON_REQUEST='{
  "jsonrpc": "2.0",
  "method": "host.create",
  "params": {
    "host": "'$HOSTNAME'",
    "interfaces": [
      {
        "type": 1,
        "main": 1,
        "useip": 1,
        "ip": "'$HOST_IP'",
        "dns": "'$HOSTNAME'",
        "port": 10050,
        "macro": [],
        "details": {
          "version": "4",
          "key": "system.uname",
          "snmp_community": "",
          "bulk": 0,
          "port": 10050
        }
      }
    ],
    "groups": [
      {
        "groupid": "'$GROUP_ID'"
      }
    ],
    "templates": [
      {
        "templateid": "'$TEMPLATE_ID'"
      }
    ],
    "inventory_mode": 0
  },
  "auth": "'$AUTH_TOKEN'",
  "id": 2
}'

# Make the API call
API_RESPONSE=$(curl -s -X POST -H 'Content-Type: application/json' -d "$JSON_REQUEST" "$API_URL" | jq '.result')

# Print API response
echo "$API_RESPONSE"

exit 0
