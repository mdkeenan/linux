#!/bin/bash

# run the following commented command to set up Ubuntu.
# sudo apt-get install curl && source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntuSetup.sh)

sudo apt update && sudo apt upgrade -y

sudo apt-get install -y net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

ORIG=~/.bashrc.original

if test -f "$ORIG"; then
    :
else
    cp ~/.bashrc ~/.bashrc.original
fi

sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~/.bashrc

sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -O ~/mycron.sh

sudo chmod +x ~/mycron.sh

CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    sudo echo "32 4 * * 0 ~/mycron.sh" >> /etc/crontab
fi

source ~/.bashrc
