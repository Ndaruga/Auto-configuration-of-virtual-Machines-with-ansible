#!/bin/bash

## check if you run the script on centos 8
if [ "$(cat /etc/centos-release | awk '{print $4}')" == "8" ]; then
    echo "Running script on centos 8..."

    ## check if you are super user doer (sudo)
    if [[ $(id -u) != 0 ]]; then
        echo "You have to be sudoer to run the script"

        ## Prompt the user to be a root/sudoer
        sudo su
        echo "You are now root"
    fi

    ## Run commands to install ansible on centos 8

    ## First, update The DNF package and enable the EPEL repository
    dnf makecache
    dnf install -y epel-release
    dnf makecache

    # Install latest version of ansible
    dnf install -y ansible
    echo "Ansible installed successfully"
    ansible --version

else
    echo "The OS must be CentOS 8 for the script to run. Please download it from here: http://isoredirect.centos.org/centos/8-stream/isos/x86_64/"
fi