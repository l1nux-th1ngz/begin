#!/bin/bash
# Update package list
echo "Updating package list..."
sudo apt update

# Install each package individually
echo "Installing required packages..."
sudo apt-get -y install bc 
sudo apt-get -y install bison
sudo apt-get -y install dh-make 
sudo apt-get -y install pbuilder
sudo apt-get -y install build-essential
sudo apt-get -y install fakeroot 
sudo apt-get -y install flex 
sudo apt-get -y install libelf-dev 
sudo apt-get -y install libncurses5-dev 
sudo apt-get -y install libssl-dev
sudo apt-get -y install autoconf
sudo apt-get -y install libparse-debcontrol-perl
sudo apt-get -y install automake
sudo apt-get -y install autopoint 
sudo apt-get -y install autotools-dev
sudo apt-get -y install debhelper
sudo apt-get -y install dh-autoreconf
sudo apt-get -y install dpkg-dev
sudo apt-get -y install devscripts
sudo apt-get -y install dh-strip-nondeterminism
sudo apt-get -y install dwz 
sudo apt-get -y install gettext
sudo apt-get -y install intltool-debian 
sudo apt-get -y install libarchive-zip-perl
sudo apt-get -y install libfl-dev
sudo apt-get -y install libdebhelper-perl
sudo apt-get -y install libfile-stripnondeterminism-perl
sudo apt-get -y install libsub-override-perl
sudo apt-get -y install libtool 
sudo apt-get -y install po-debconf

# Install backports kernel and firmware
echo "Installing Linux backports kernel and firmware..."
sudo apt install -t bookworm-backports linux-image-amd64 linux-headers-amd64 firmware-linux

# Refresh
sudo apt-get update

# Update GRUB
update-grub

echo "Done"
