#!/bin/bash

# Run the following commented command to set up Ubuntu.
# sudo apt-get install curl && source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntuSetup.sh)

# Update and upgrade the system.
sudo apt update && sudo apt upgrade -y -q

# Install my commonly used packages.
sudo apt-get install -y -q net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change.
ORIG="~/.bashrc.original"

if test -f "$ORIG"; then
    :
else
    echo "NOTE: ~/.bashrc.original does not exist. Making copy."
    cp ~/.bashrc ~/.bashrc.original
fi

# Download and replace bashrc file for current user.
sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~/.bashrc

# Download mycron.sh file that contains a list of regularly scheduled commands.
sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -O ~/mycron.sh

# Make mycron.sh executable.
sudo chmod +x ~/mycron.sh

# Check if the string "mycron" exists in the crontab file. If it does not then add the mycron.sh line to it.
CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    echo "NOTE: ~/mycron.sh is not amended to crontab. Amending."
    sudo echo "32 4 * * 0 ~/mycron.sh" >> /etc/crontab
fi

# Refresh bashrc
source ~/.bashrc
