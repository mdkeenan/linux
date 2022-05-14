#!/bin/bash

# run the following commented command to set up Ubuntu.
# sudo apt-get install curl && source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntuSetup.sh)

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get install -y net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev open-vm-tools

sudo cp ~/.bashrc ~/.bashrc.original

sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~/.bashrc

sudo wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -O ~/.mycron.sh

sudo chmod +x ~/.mycron.sh

echo "32 4 * * 0 ~/.mycron.sh" >> /etc/crontab

sudo cp ~/.bashrc /root/.bashrc

source ~/.bashrc
