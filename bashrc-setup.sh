#!/bin/bash

# Run the following commented command to set up bashrc.
# source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc-setup.sh)
# curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc-setup.sh | bash

# Check if ~/.bashrc.original already exists. If it does not then make a copy of the original before change. Also check to see which user is logged in and place bashrc file in the appropriate directory.

sudo timedatectl set-timezone America/New_York

curl https://raw.githubusercontent.com/mdkeenan/linux/master/sshkeys-1 >> ~/.ssh/authorized_keys

ROOTRCCOPY="/root/.bashrc.original"
USERRCCOPY="/home/$USER/.bashrc.original"

if  test "$USER" = "root"; then
    if test -f "$ROOTRCCOPY"; then
        :
    else
        sudo cp /root/.bashrc /root/.bashrc.original
    fi
else
    if test -f "$USERRCCOPY"; then
        :
    else
        sudo cp /home/$USER/.bashrc /home/$USER/.bashrc.original
    fi
fi

# Download and replace bashrc file for current user.
sudo curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -o ~/.bashrc

# Refresh bashrc
source ~/.bashrc
