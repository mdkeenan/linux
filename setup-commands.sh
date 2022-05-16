#!/bin/bash

# Run the following commented command AS ROOT to set up the system.
# apt-get install -qqym curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup.sh)

# Set timezone to America/New_York
sudo timedatectl set-timezone America/New_York

# Set apt-get to non-interactive.
echo "Setting DEBIAN_FRONTEND to noninteractive".
export DEBIAN_FRONTEND=noninteractive

echo "Starting apt-get update and apt-get upgrade."
# Update and upgrade the system.
apt-get update -y
apt-get upgrade -y

echo "Finished apt-get update and apt-get upgrade."

echo "Starting apt-get install common tools."
# Install my commonly used packages.
apt-get install -ym net-tools openssh-server build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

echo "Finished apt-get install common tools."

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change.
echo "Making copy of bashrc"
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

echo "Downloading bashrc file and setting it as ~/.bashrc"

# Download and replace bashrc file for current user.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -o ~/.bashrc

echo "Done donwloading bashrc file and setting it as ~/.bashrc"

echo "Downloading mycron.sh and setting it as /usr/local/src/mycron.sh"

# Download mycron.sh file that contains a list of regularly scheduled commands.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.sh

echo "Done downloading mycron.sh and setting it as /usr/local/src/mycron.sh"

echo "Downloading ocrap.sh file and setting it as /usr/local/src/ocrap.sh"

# Download ocrap.sh file that contains a list of commands that are ran every hour.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh -o /usr/local/src/ocrap.sh

echo "Done downloading ocrap.sh file and setting it as /usr/local/src/ocrap.sh"

echo "Making mycron.sh and ocrap.sh executable."

# Make mycron.sh and ocrap.sh executable.
chmod +x /usr/local/src/mycron.sh
chmod +x /usr/local/src/ocrap.sh

echo "Done making mycron.sh and ocrap.sh executable."

echo "Adding mycron.sh to crontab."
# Check if the string "mycron" exists in the crontab file. If it does not then add the mycron.sh line to it.
export CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/mycron.sh is not amended to crontab. Amending."
    echo "32 4 * * 0 root sh /usr/local/src/mycron.sh" >> /etc/crontab
fi

echo "Done adding mycron.sh to crontab."

# Check if the string "ocrap" exists in the crontab file. If it does not then add the ocrap.sh line to it.
echo "Adding ocrap.sh to crontab."
if grep -q ocrap "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/ocrap.sh is not amended to crontab. Amending."
    echo "0 * * * * root sh /usr/local/src/ocrap.sh" >> /etc/crontab
fi

echo "Done adding ocrap.sh to crontab."
echo "Refreshing bashrc"

# Refresh bashrc
source ~/.bashrc
