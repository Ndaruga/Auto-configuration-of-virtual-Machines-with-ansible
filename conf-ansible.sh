#!/bin/bash

host_file="/etc/ansible/hosts"
conf_file="/etc/ansible/ansible.cfg"


# Function to validate, ping and add IP address to host file
validate_ip(){
	if [[ "$1" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        # ping the IP address with 4 packets, discarding the output
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
        # Skip the rest of the loop to prompt for another IP address
		continue
	fi

    # Reset the consecutive empty line counter if a non-empty line is entered
	consec=0
	validate_ip "$ip_add"
done

# check if config file for ansible server is uodated. otherwise update
if grep -q "inventory=/etc/ansible/hosts" "$conf_file"; then
	sudo echo "inventory=/etc/ansible/hosts" >> "$conf_file"
	sudo echo "sudo-user=root" >> "$conf_file"
fi

# Create a new user for ansible controler and the managed nodes
echo "Please create a new user"
echo
read -p "New User: " username
sudo adduser $username
sudo passwd $username
exit