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

# Loop until 

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

# Add User to the sudo Group
echo "Enter root Password then type 'exit'"
su root

# Check if the user is already in the sudoers file
if grep -q "$username ALL=(ALL) NOPASSWD: ALL" "/etc/sudoers"; then
    echo "User $username already in sudoers file"
else
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers"
	echo "Adding user $username to sudoers file"
fi
su root
sudo chmod 440 /etc/sudoers

# Restart the ssh server
sudo systemctl restart sshd

exit