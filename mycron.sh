#!/bin/bash

# This will update from https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh every Sundary at 04:32 and run the commands.
# 32 4 * * 0 root sh /usr/local/src/mycron.sh >> /etc/crontab

MYCRONCOPY="/usr/local/src/mycron.sh"

if  test -f "$MYCRONCOPY"; then
    curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/mycron.sh -o /usr/local/src/mycron.varsource

    cp /usr/local/src/mycron.sh /usr/local/src/mycron.varlocal

    MYCRONSUMSOURCE=$(sha256sum /usr/local/src/mycron.varsource)
    MYCRONSUMLOCAL=$(sha256sum /usr/local/src/mycron.varlocal)

    MYCRONSUMSOURCE2=$(echo $MYCRONSUMSOURCE | awk -F" " '{print $1}')
    MYCRONSUMLOCAL2=$(echo $MYCRONSUMLOCAL | awk -F" " '{print $1}')
elif test "$MYCRONSUMSOURCE2" = "$MYCRONSUMLOCAL2"; then
    :
else
    cp /usr/local/src/mycron.varsource /usr/local/src/mycron.sh
fi

rm /usr/local/src/mycron.varsource
rm /usr/local/src/mycron.varlocal

# Enter commands below this line.

# sudo apt-get update && sudo apt-get upgrade -y -qq > /dev/null
