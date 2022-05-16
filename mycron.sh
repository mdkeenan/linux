#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

CRONY="/etc/crontab"

if grep -q mycron "$CRONY"; then
    :
else
    echo "NOTE: /usr/local/src/mycron.sh is not amended to crontab. Amending."
    echo "32 4 * * 0 root sh /usr/local/src/mycron.sh" >> /etc/crontab
fi

curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.sh
