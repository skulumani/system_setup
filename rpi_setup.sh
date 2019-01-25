sudo apt-get update
sudo apt-get install vim git default-jre
sudo apt-get install libunixsocket-java # for Signal dbus 
sudo apt-get install python3 python3-dev

# basic git setup
git config --global user.name "Shankar - RPi"
git config --global user.email shanks.k@gmail.com

# setup ssh keys
ssh-keygen -t rsa -b 4096 -C "shanks.k@gmail.com"
ssh-add ~/.ssh/id_rsa

# download signal and add to path

# download no-ip dynamic update client

# download Pi VPN



