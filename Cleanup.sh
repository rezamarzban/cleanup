#!/bin/bash

# Update package lists
sudo apt update

# Remove unnecessary packages
sudo apt autoremove -y

# Clear package cache
sudo apt clean
sudo apt autoclean

# Remove old kernels
sudo apt purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') -y

# Clear thumbnail cache
rm -r ~/.cache/thumbnails/*

# Remove old logs
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.1

# Clean temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Remove unused packages
sudo apt install deborphan -y
deborphan | xargs sudo apt-get -y remove --purge

# Install and run BleachBit (optional)
# sudo apt install bleachbit -y
# bleachbit --clean

# Reboot the system
echo "Cleanup complete. Rebooting the system..."
sudo reboot
