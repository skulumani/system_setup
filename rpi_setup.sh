#!/bin/bash

sudo apt-get update
sudo apt-get install vim git tmux

echo "Now going to setup ssh key for git"
read -p "Press enter to continue"

# setup ssh keys
ssh-keygen -t rsa -b 4096 -C "shanks.k@gmail.com"
ssh-add ~/.ssh/id_rsa

echo "Now setting up docker and docker-compose"
read -p "Press enter to continue"

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
sudo su - ${USER}

docker version

echo "Docker should be installed. Now installing docker-compose"
read -p "Press enter to continue"

sudo apt-get -y install libffi-dev libssl-dev python3-dev python3 python3-pip
sudo pip3 install docker-compose

# syncthing and borgbackup
echo "Now going to install and setup syncthing"
read -p "Press enter to continue"

curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt update
sudo apt install syncthing
syncthing

echo "Change address to 0.0.0.0:8384 in the ~/.config/syncthing/config.xml"
read -p "Press enter to continue"

sudo vim ~/.config/syncthing/config.xml

sudo wget https://raw.githubusercontent.com/syncthing/syncthing/master/etc/linux-systemd/system/syncthing%40.service -O /etc/systemd/user/syncthing@.service

sudo systemctl enable syncthing@pi.service
sudo reboot

# borgbackup
