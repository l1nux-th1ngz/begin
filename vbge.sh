#!/bin/bash

# Check if script is run as root, otherwise exit
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root or with sudo." 
  exit 1
fi

# Update package list and install prerequisites
echo "Updating package list and installing dependencies..."
sudo apt update
sudo apt-get -y install curl wget dkms build-essential linux-headers-$(uname -r) make bzip2
sudo apt-get -y install adduser 
sudo apt-get -y install gnome-system-tools
sudo apt-get -y install rcconf
sudo apt-get -y install cfengine3

# Refresh
sudo apt-get update

# Download the Guest Additions ISO
echo "Downloading VirtualBox Guest Additions version 7.0.22..."
wget -q https://download.virtualbox.org/virtualbox/7.0.22/VBoxGuestAdditions_7.0.22.iso -O /tmp/VBoxGuestAdditions.iso

# Mount the ISO
echo "Mounting the ISO..."
sudo mount -o loop /tmp/VBoxGuestAdditions.iso /mnt

# Install the Guest Additions
echo "Installing VirtualBox Guest Additions..."
sudo sh /mnt/VBoxLinuxAdditions.run --nox11

# Add user to groups, create the groups if they do not exist
if ! getent group vboxsf > /dev/null; then
  sudo groupadd vboxsf
fi
sudo usermod -a -G vboxsf "$USER"

if ! getent group vboxusers > /dev/null; then
  sudo groupadd vboxusers
fi
sudo usermod -a -G vboxusers "$USER"

# Clean up
echo "Cleaning up..."
sudo umount /mnt
rm /tmp/VBoxGuestAdditions.iso

# Refresh
sudo apt-get update

wait

# Reboot the system to finalize the installation
echo "Installation complete. Rebooting the system..."
sudo reboot
