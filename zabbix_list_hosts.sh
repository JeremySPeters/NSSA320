#!/bin/bash
# Author: Jeremy Peters

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <api_url> <auth_token>"
  exit 1
fi

# Extract arguments
ZABBIX_SERVER_IP="$1"
AUTH_TOKEN="$2"

# Construct the Zabbix API URL
ZABBIX_API_URL="http://${ZABBIX_SERVER_IP}:10051/api_jsonrpc.php"

# Make the API call to retrieve host information
API_RESPONSE=$(curl -s -X POST -H 'Content-Type: application/json' -d '{
  "jsonrpc": "2.0",
  "method": "host.get",
  "params": {
    "output": "extend"
  },
  "auth": "'$AUTH_TOKEN'",
  "id": 2
}' $ZABBIX_API_URL | jq '.result')

# Print results
echo "$API_RESPONSE"

exit 0
