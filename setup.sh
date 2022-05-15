#!/bin/bash

# Run the following commented command to set up Ubuntu.
# sudo apt-get install curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup.sh)

# Set apt-get to non-interactive.
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system.
sudo apt-get update && sudo apt-get upgrade -y -qq > /dev/null

# Install my commonly used packages.
sudo apt-get install --ignore-missing -qqy net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change.
export ROOTRCCOPY="/root/.bashrc.original"
export USERRCCOPY="/home/$USER/.bashrc.original"

if  test "$USER" = "root"; then
    if test -f "$ROOTRCCOPY"; then
        :
    else
        echo "NOTE: $ROOTRCCOPY does not exist. Making copy of bashrc."
        sudo cp /root/.bashrc /root/.bashrc.original
    fi
else
    if test -f "$USERRCCOPY"; then
        :
    else
        echo "NOTE: $USERRCCOPY does not exist. Making copy of bashrc."
        sudo cp /home/$USER/.bashrc /home/$USER/.bashrc.original
    fi
fi

# Download and replace bashrc file for current user.
sudo curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -o ~/.bashrc
# sudo wget -q --no-check-certificate https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~/.bashrc

# Download mycron.sh file that contains a list of regularly scheduled commands.
sudo curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.sh
# sudo wget -q --no-check-certificate https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -O /usr/local/src/mycron.sh

# Download ocrap.sh file that contains a list of commands that are ran every hour.
sudo curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.sh

# Make mycron.sh and ocrap.sh executable.
sudo chmod +x /usr/local/src/mycron.sh
sudo chmod +x /usr/local/src/ocrap.sh

# Check if the string "mycron" exists in the crontab file. If it does not then add the mycron.sh line to it.
export CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/mycron.sh is not amended to crontab. Amending."
    sudo echo "32 4 * * 0 root sh /usr/local/src/mycron.sh" >> /etc/crontab
fi

# Check if the string "ocrap" exists in the crontab file. If it does not then add the ocrap.sh line to it.

if grep -q ocrap "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/ocrap.sh is not amended to crontab. Amending."
    sudo echo "0 * * * * root sh /usr/local/src/ocrap.sh" >> /etc/crontab
fi

# Refresh bashrc
source ~/.bashrc
