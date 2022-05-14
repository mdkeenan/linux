#!/bin/bash

# Run the following commented command to set up Ubuntu.
# sudo apt-get install curl && source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntuSetup.sh)

# Update and upgrade the system.
sudo apt-get update && sudo apt-get upgrade -y -qq > /dev/null

# Install my commonly used packages.
sudo apt-get install -y -qq net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change.
ROOTRCCOPY="/root/.bashrc.original"
USERRCCOPY="/home/$USER/.bashrc.original"

if  test "$USER" = "root"; then
    if test -f "$ROOTRCCOPY"; then
        :
    else
        echo "NOTE: $ROOTRCCOPY does not exist. Making copy of bashrc."
        cp /root/.bashrc /root/.bashrc.original
    fi
else
    if test -f "$USERRCCOPY"; then
        :
    else
        echo "NOTE: $USERRCCOPY does not exist. Making copy of bashrc."
        cp /home/$USER/.bashrc /home/$USER/.bashrc.original
    fi
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
