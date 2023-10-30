#!/bin/bash
# Author: Jeremy Peters

# Define the network interface and IP address you want to set
interface="ens192"
ip_address="192.168.200.7"
subnet_mask="255.255.248.0"
gateway="192.168.207.254"

# Set the static IP address
echo "Setting static IP address for $interface..."

# Using 'ifconfig' (older method, still works on some systems)
# sudo ifconfig $interface $ip_address netmask $subnet_mask
# sudo route add default gw $gateway $interface

# Using 'ip' (recommended, works on most modern systems)
sudo ip addr flush dev $interface
sudo ip addr add $ip_address/$subnet_mask dev $interface
sudo ip route add default via $gateway dev $interface

# Display the updated network configuration
echo "Updated IP address for $interface:"
ip addr show $interface

# Optional: Save the changes to a configuration file
# Note: Configuration file paths may vary based on your Linux distribution
# For example, in Debian/Ubuntu, you can edit /etc/network/interfaces
# echo -e "auto $interface\niface $interface inet static\n  address $ip_address\n  netmask $subnet_mask\n  gateway $gateway" | sudo tee -a /etc/network/interfaces

echo "Static IP address set successfully for $interface."
