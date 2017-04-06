# !/bin/bash

echo "Installing your Ubuntu workflow"
echo "Setting up NVIDIA graphics"
# add repos
# install NVIDIA graphics drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
echo "Now downloading Google chrome"
# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb

echo "Downloading zsh"
sudo apt-get -y install zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

sudo apt-get install google-chrome-stable

# Now install vim and associated tools
echo "Now setting up vim"
sudo apt-get -y install vim-gtk zathura zathura-dev 
sudo apt-get -y install exuberant-ctags
# Need to setup SSH keys prior to downloading repos

