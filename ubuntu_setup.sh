#!/bin/bash

# source <(curl -s https://raw.githubusercontent.com/mdkeenan/linux/master/ubuntu_setup.sh)

sudo apt-get update -y && apt-get upgrade -y

sudo apt-get install -y net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev

wget -O https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc ~/.bashrc

source ~/.bashrc
