#!/bin/bash
# Author: Jeremy Peters

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <zabbix_server_ip> <auth_token> <host_id>"
  exit 1
fi

# Extract arguments
ZABBIX_SERVER_IP="$1"
AUTH_TOKEN="$2"
HOST_ID="$3"

# Construct the JSON request to delete the host
JSON_REQUEST='{
  "jsonrpc": "2.0",
  "method": "host.delete",
  "params": [
    "'$HOST_ID'"
  ],
  "auth": "'$AUTH_TOKEN'",
  "id": 1
}'

# Construct the Zabbix API URL
ZABBIX_API_URL="http://${ZABBIX_SERVER_IP}:10051/api_jsonrpc.php"

# Make the API call to delete the host and pipe the result to jq
curl -s -X POST -H 'Content-Type: application/json' -d "$JSON_REQUEST" "$ZABBIX_API_URL" | jq '.result'

exit 0
