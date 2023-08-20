#!/usr/bin/bash

sudo dnf makecache
sudo dnf install -y epel-release
sudo dnf makecache
sudo dnf install -y ansible
ansible --version
