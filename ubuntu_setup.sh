#!/bin/bash

sudo apt-get update -y && apt-get upgrade -y

wget https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc -O ~./bashrc

sudo apt-get install -y net-tools build-essential curl wget mlocate git gnupg nano tcpdump python3 python3-dev python3-pip libssl-dev libffi-dev

source ~./bashrc
