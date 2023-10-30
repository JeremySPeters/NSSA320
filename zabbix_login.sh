#!/bin/bash
# Author: Jeremy Peters


# Check if all required arguments are provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <zabbix_server_ip> <username> <password>"
  exit 1
fi

# Extract arguments
ZABBIX_SERVER_IP="$1"
USERNAME="$2"
PASSWORD="$3"

# Zabbix API URL
ZABBIX_API_URL="http://${ZABBIX_SERVER_IP}:10051/api_jsonrpc.php"

# Authenticate and get the authentication token
SESSION_TOKEN=$(curl -s -X POST -H 'Content-Type: application/json' -d '{
  "jsonrpc": "2.0",
  "method": "user.login",
  "params": {
    "user": "'$USERNAME'",
    "password": "'$PASSWORD'"
  },
  "id": 1
}' $ZABBIX_API_URL | jq -r '.result')

if [ -z "$SESSION_TOKEN" ]; then
  echo "Authentication failed. Check your credentials or API URL."
  exit 1
fi

# Print token
echo "$SESSION_TOKEN"

exit 0
