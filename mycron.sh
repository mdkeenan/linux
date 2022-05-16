#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

# Download current version of ocrap.sh and save it to ocraptmp.sh
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycrontmp.sh

# Download latest version of ocrap-commands.sh.
curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron-commands.sh | sudo bash

# Replace old version of ocrap.sh with new version.
mv /usr/local/src/mycrontmp.sh /usr/local/src/mycron.sh
