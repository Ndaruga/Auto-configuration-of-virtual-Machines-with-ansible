#!/bin/bash

# Check version
version=$(VBoxManage --version)
echo "VirtualBox version: $version"

# List all virtual machines
listAll=$(VBoxManage list vms)
echo "Listing available Virtual Machines ..."
echo "$listAll"

# List all running virtual machines
echo "List the running Virtual Machines"
VBoxManage list runningvms

echo
echo "Showing the VM info..."
# Prompt user for VM name
read -p "Enter the VM name: " VMName

# Check if VM exists and display info if it does
VBoxManage showvminfo "$VMName"

echo
echo

# Start vms
echo "Starting Multiple VMs"
# Define the list of VMs to start
read -p "Enter names of VMs you'd like to start,separated by a white space: " VMsToStart

# Start each VM in the list
for VM in $VMsToStart; do
    VBoxManage startvm "$VM" --type headless
    echo
done

pause
