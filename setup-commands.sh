#!/bin/bash

# Run the following commented command AS ROOT to set up the system.
# apt-get install -qqym curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup.sh)

# Set timezone to America/New_York
sudo timedatectl set-timezone America/New_York

# Set apt-get to non-interactive.
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system.
apt-get update -y
apt-get upgrade -y

# Install my commonly used packages.
apt-get install -ym net-tools openssh-server curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip open-vm-tools

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change.
export ROOTRCCOPY="/root/.bashrc.original"
export USERRCCOPY="/home/$USER/.bashrc.original"

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
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -o ~/.bashrc

# Download mycron.sh file that contains a list of regularly scheduled commands.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.sh

# Download ocrap.sh file that contains a list of commands that are ran every hour.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.sh

# Make mycron.sh and ocrap.sh executable.
chmod +x /usr/local/src/mycron.sh
chmod +x /usr/local/src/ocrap.sh

# Check if the string "mycron" exists in the crontab file. If it does not then add the mycron.sh line to it.
export CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/mycron.sh is not amended to crontab. Amending."
    echo "32 4 * * 0 root sh /usr/local/src/mycron.sh" >> /etc/crontab
fi

# Check if the string "ocrap" exists in the crontab file. If it does not then add the ocrap.sh line to it.
if grep -q ocrap "$CRONY"; then
    :
else
    echo "0 * * * * root sh /usr/local/src/ocrap.sh" >> /etc/crontab
fi

# Refresh bashrc
source ~/.bashrc
