Check the Apache version
```bash
curl -sI http://your_domain_or_ip | grep "Server:"
```
As a bash script that takes IP as an argument
```bash
#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ip_address_or_domain>"
    exit 1
fi

# Fetch the server header
server_header=$(curl -sI http://$1 | grep "Server:")

# Check and display the server header
if [ -z "$server_header" ]; then
    echo "Server header not found or no response from $1."
else
    echo "$server_header"
fi

```
