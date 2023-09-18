# Security Tools
## Scripts
### Local
Scripts tagged with "local" in their name must be run on/from the target deployment.

#### Apache Directory Check
##### Synopsis   
Short script to verify server that is not displaying all files from the Apache web root directory.
##### Requirements
Will need to be run by an account that has permssions to access configuration files stored in "/etc/".
##### Notable Interactions
Reads
```bash
/etc/httpd/httpd.conf
```
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
##### Known Issues
N/A
##### Planned Features
- Allow user to pass a path for the configuration file(s) to check as oposed to using hardcoded values

### FollowSymLink Check
#### Synopsis
Script checks that "FollowSymLinks" has been removed from configuration file(s).
##### Requirements
Will need to be run by an account that has permssions to access configuration files stored in "/etc/".
##### Notable Interactions
Reads
```bash
/etc/httpd/httpd.conf
/etc/httpd/conf.d/*
```
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
##### Known Issues
N/A
##### Planned Features
- Allow user to pass a path for the configuration file(s) to check as oposed to using hardcoded values

### Package Verify
#### Synopsis
Checks that given package(s) are installed on deployment.
##### Requirements
User who runs script has access to "rpm" command
##### Notable Interactions
N/A
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
##### Known Issues
N/A
##### Planned Features
N/A

### Port Check
#### Synopsis
Checks what ports are open/listening and reports back any that are not excluded from check.
##### Requirements
- net-tools package
- Run by a user who has permission to run netstat
##### Notable Interactions
N/A
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
##### Known Issues
N/A
##### Planned Features
Would like to remove netstat dependency and make this a remote script

### Remote
These scripts can be run from any device on the same network segment as target deployment.
### Apache Header Check
#### Synopsis
Checks that the apache version info has been stripperd from http header.
##### Requirements
- jq package
- Run by a user who has permission to run curl calls.
##### Notable Interactions
N/A
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
##### Known Issues
N/A
##### Planned Features
Remove "server_header_found" and just operate off of "header_value"
