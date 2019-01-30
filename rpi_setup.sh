sudo apt-get update
sudo apt-get install vim git tmux
sudo apt-get install transmission-daemon transmission-common transmission-cli

# setup ssh keys
ssh-keygen -t rsa -b 4096 -C "shanks.k@gmail.com"
ssh-add ~/.ssh/id_rsa

# download signal and add to path

# download no-ip dynamic update client

# download Pi VPN

# setup anaconda lite

# stop transmission daemon so we can edit the config options
sudo service transmission-daemon stop

echo "Now copy and edit /var/lib/transmission-daemon/info/settings.json"

read -p "Press Enter to continue"

echo "You can install specific dotfiles using bash install_standalone.sh git bash vim"
echo "Choose the ones you wnat"



