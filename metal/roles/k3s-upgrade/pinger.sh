#!/bin/bash

subnet_cidr="192.168.3.1/24"

# Calculate the range of IP addresses in the subnet
start_ip=$(ipcalc -n -b $subnet_cidr | grep HostMin | awk '{print $2}')
end_ip=$(ipcalc -n -b $subnet_cidr | grep HostMax | awk '{print $2}')

# Convert the last octet of the start and end IP addresses to integers
start_octet=$(echo $start_ip | awk -F'.' '{print $4}')
end_octet=$(echo $end_ip | awk -F'.' '{print $4}')

# Iterate through the IP addresses and send ping requests
for ((octet=$start_octet; octet<=$end_octet; octet++)); do
    current_ip=$(echo $start_ip | awk -F'.' -v o=$octet '{print $1 "." $2 "." $3 "." o}')
    ping -c 1 $current_ip > /dev/null
    if [ $? -eq 0 ]; then
        echo "$current_ip is reachable"
    else
        echo "$current_ip is not reachable"
    fi
done