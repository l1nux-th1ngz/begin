#!/bin/bash

echo "Installing necessary keyring..."
sudo apt-get -y install fasttrack-archive-keyring

echo "Updating package lists..."
sudo apt-get update

echo "Erasing existing contents of sources.list and adding new repositories..."
sudo bash -c 'cat <<EOF > /etc/apt/sources.list
deb https://fasttrack.debian.net/debian-fasttrack/ bookworm-fasttrack main contrib non-free
deb https://ftp.debian.org/debian/ bookworm contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-proposed-updates contrib main non-free non-free-firmware
deb https://ftp.debian.org/debian/ bookworm-backports contrib main non-free non-free-firmware
deb https://security.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware
EOF'

echo "Updating package lists again..."
sudo apt-get update
