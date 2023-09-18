# NSSA320
## Scripts
### Local
Scripts tagged with "local" in their name must be run on/from the target deployment.

#### Apache Directory Check
##### Synopsis   
Short script to verify server that is not displaying all files from the Apache web root directory.
##### Usage
```bash
./local_apache_directory_check.sh
```
##### Output
```bash
{"directory_listing_disabled": true}
```
or
```bash
{"directory_listing_disabled": false}
```

### FollowSymLink Check
#### Synopsis
Script checks that "FollowSymLinks" has been removed from configuration file(s).
##### Usage
```bash
./local_fsl_check.sh
```
##### Output
```bash
{"followsymlinks_enabled": true}
```
or
```bash
{"followsymlinks_enabled": false}
```

### Package Verify
#### Synopsis
Checks that given package(s) are installed on deployment.
##### Usage
```bash
./local_package_check.sh [PACKAGE(S)]
```
Ex.
```bash
./local_package_check.sh fail2ban net-tools
```
##### Output
```bash
{"[PACKAGE]": true}
```
or
```bash
{"[PACKAGE]": false}
```

### Port Check
#### Synopsis
Checks what ports are open/listening and reports back any that are not excluded from check.
##### Usage
```bash
./local_port_check.sh [PORT(S) TO EXCLUDE]
```
Ex.
```bash
./local_port_check.sh 80 22 443
```
##### Output
```bash
{"open_ports": [PORTS]}
```

### Remote
These scripts can be run from any device on the same network segment as target deployment.
### Apache Header Check
#### Synopsis
Checks that the apache version info has been stripperd from http header.
##### Usage
```bash
./remote_apache_header_check.sh [IP/HOST]
```
Ex.
```bash
./remote_apache_header_check.sh 192.168.123.123
```
##### Output
```bash
{"server_header_found": false}
```
or
```bash
{"server_header_found": true, "header_value": Apache/2.4.52 (Ubuntu)}
```
or
```bash
{"server_header_found": true, "header_value": Apache}
```
