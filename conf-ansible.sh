#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root."
	read -p "Do you want to run the script as root now? (y/n): " choice

	if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
	# Re-run the script using sudo
	exec sudo "$0" "$@"
	else
		echo "Exiting the script."
		exit 1
	fi
fi

## -------------------------VARIABLES---------------------##
consec=0
host_file="/etc/ansible/hosts"
conf_file="/etc/ansible/ansible.cfg"
sshd_config_path="/etc/ssh/sshd_config"
# Temporary file for sudoers
temp_sudoers=$(mktemp)
# Create a backup and then copy existing sudoers to temp
cp -p /etc/sudoers $temp_sudoers
chmod 666 $hostfile
## ----------------------------------------------------------
# Function to validate, ping and add IP address to host file
validate_ip(){
	if [[ "$1" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        # ping the IP address with 4 packets, discarding the output
		if ping -c 4 "$1" > /dev/null 2>&1; then
			echo "Host $1 is reachable"
			if grep -q "$1" "$host_file"; then
				echo
			else
				echo "$1" >> "$host_file"
			fi
		else
			echo "Destination $1 is not reachable"
		fi
	else
		echo "Invalid IP address: $1"
	fi
}

# Loop until user presses Enter twice

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
	echo "inventory=/etc/ansible/hosts" >> "$conf_file"
	echo "sudo-user=root" >> "$conf_file"
fi

# Create a new user for ansible controler and the managed nodes
echo "Please create a new user"
echo
read -p "New User: " username
adduser $username
passwd $username

# Check if the user is already in the sudoers file
if grep -q "$username ALL=(ALL) NOPASSWD: ALL" $temp_sudoers; then
    echo "User $username already in sudoers file."
else
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> $temp_sudoers
	echo "Allowing user $username to run all commands without a password."
    
    # Validate and update sudoers
    visudo -c -f $temp_sudoers
    if [ $? -eq 0 ]; then
		cp $temp_sudoers /etc/sudoers
		echo "User $username added to sudoers file."
    else
		echo "ERROR: sshd_config file either doesn't exist or is not writable."
    fi
fi


# Check if the file exists and is writable
if [[ -f "$sshd_config_path" && -w "$sshd_config_path" ]]; then
	# Uncomment the lines for PubkeyAuthentication and PasswordAuthentication, or add them if they don't exist
	sed -i '/^#PubkeyAuthentication yes/s/^#//' "$sshd_config_path"
	sed -i '/^#PasswordAuthentication yes/s/^#//' "$sshd_config_path"

	# Check if the lines exist; if not, append them
	grep -q "^PubkeyAuthentication yes" "$sshd_config_path" || echo "PubkeyAuthentication yes" >> "$sshd_config_path"
	grep -q "^PasswordAuthentication yes" "$sshd_config_path" || echo "PasswordAuthentication yes" >> "$sshd_config_path"

	echo "Authentication Configuration updated successfully."
fi

# Restart the ssh server
systemctl restart sshd
systemctl status sshd
exit
