#!/bin/bash

# Run the following commented command AS ROOT to set up Ubuntu.
# sudo apt-get install -qqym curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup.sh)

# If user is root download and run the commands in setup-commands.sh. If not then dont.
if  test "$USER" = "root"; then
    apt-get install -qqym curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup-commands.sh)
else
    echo "Must be ran as root. To setup bashrc only which does not need root run the following command."
    echo "source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc-setup.sh)"
fi
