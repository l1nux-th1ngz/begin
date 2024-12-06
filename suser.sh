#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

# Prompt for the username
read -p "Type your user name, be exact, and press Enter: " ANS

# Add user to the sudo group
usermod -aG sudo "$ANS"
echo "Configuring sudoers..."

# Configure sudoers for no password requirement
echo "$ANS ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$ANS

# Visudo to edit sudoers file (this step will open visudo editor)
echo "$ANS ALL=(ALL:ALL) ALL" >> /etc/sudoers
visudo

# Update and prompt for reboot
echo "Updating package lists..."
sudo apt-get update

# Final instructions
echo "DONE"
echo "Please save and close the sudoers file, then update and reboot."
exit 0
