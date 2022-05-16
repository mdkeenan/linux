#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

sudo apt-get update && sudo apt-get upgrade -y -qq > /dev/null

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.sh
