#!/bin/bash

# This will be ran by https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap.sh every hour on applicable machines.
# Can also be ran with: source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/ocrap-commands.sh)

# Log the date and time the command is ran to the ocraplog.log.
now=$(date)
echo "ocrap.sh ran at $now" >> /usr/local/src/ocrap.log
