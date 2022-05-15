echo "Making copy of bashrc"
export ROOTRCCOPY="/root/.bashrc.original"
export USERRCCOPY="/home/$USER/.bashrc.original"

if  test "$USER" = "root"; then
    apt-get install -qqym curl && source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/setup.sh)
else
    echo "Must be ran as root. To setup bashrc only which does not need root run the following command."
    echo "source <(curl -kfsSL https://raw.githubusercontent.com/mdkeenan/linux/master/bashrc-setup.sh)"
fi
