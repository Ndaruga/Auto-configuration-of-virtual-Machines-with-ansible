#!/bin/bash

host_file="/etc/ansible/hosts"

# Variable to store the IP addresses
validate_ip(){
	if [[ "$1" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
		if ping -c 4 "$1" > /dev/null 2>&1; then
			echo "Host $1 is reachable"
			if grep -q "$1" "$host_file"; then
				echo
			else
				sudo chmod 646 $hostfile
				sudo echo "$1" >> "$host_file"
			fi
		else
			echo "Destination $1 is not reachable"
		fi
	else
		echo "Invalid IP address: $1"
	fi
}
consec=0
# Loop until the Esc key is pressed
#if [[ $(id -u) != 0 ]]; then
#	echo "You must be root to run this script"
#	sudo su
#fi

while true; do
	read -p "Please enter an IP address (press Enter twice to exit): " ip_add
	if [[ -z $ip_add ]]; then
		((consec++))
		if [[ $consec -ge 2 ]]; then
			echo "Exiting ..."
			break
		fi
		continue
	fi
	consec=0
	validate_ip "$ip_add"
done
exit