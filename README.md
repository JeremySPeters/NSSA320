# NSSA320
## Scripts
### port_check.sh
#### Usage
Base Command
```bash
./port_check.sh [ports to exclude]
```
Example Usage
```
./port_check.sh 20,443,21
```
#### Input
| Argument Description          | Required | Example    |
|-------------------------------|----------|------------|
| Comma seperated list of ports | True     | 20,443,21  |

#### Output
| Key          | Value Description  | Example                                      |
|--------------|--------------------|----------------------------------------------|
| open_ports   | list of open ports | ["80", "443", ...]                           |
| error        | Usage error        | "Usage: ./scriptname <ip_address_or_domain>" |
##### Examples
There are open ports
```bash
{
  "open_ports": ["80", "443", ...]
}
```
No argument is provided
```bash
{
  "error": "Usage: ./scriptname <comma-separated ports to exclude>"
}
```
### Script 2

#### Output
| Key                 | Value Description       | Example                                      |
|---------------------|-------------------------|----------------------------------------------|
| server_header_found | Was apache header found | true                                         |
| header_value        | Apache header value     | "Apache/2.4.38 (Debian)"                     |
| error               | Usage error             | "Usage: ./scriptname <ip_address_or_domain>" |
Header is found
```bash
{
  "server_header_found": true,
  "header_value": "Apache/2.4.38 (Debian)"
}
```

Header is not found
```bash
{
  "server_header_found": false
}
```

No argument is provided
```bash
{
  "error": "Usage: ./scriptname <ip_address_or_domain>"
}
```
