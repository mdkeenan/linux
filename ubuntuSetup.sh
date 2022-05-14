#!/bin/bash

# run the following commented command to set up Ubuntu.
# source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntuSetup.sh)

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get install -y net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev

sudo cp ~/.bashrc ~/.bashrc.original

wget -q https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~/.bashrc

sudo cp ~/.bashrc /root/.bashrc

source ~/.bashrc
