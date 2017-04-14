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

echo "Installing applications"
sudo apt-get -y install google-chrome-stable
sudo apt-get -y install redshift-gtk
# Now install vim and associated tools
echo "Now setting up vim"
sudo apt-get -y install vim-gnome zathura zathura-dev xdotool 
sudo apt-get -y install exuberant-ctags
# Need to setup SSH keys prior to downloading repos

# # setup Ruby for the website development
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# \curl -sSL https://get.rvm.io | bash -s stable --ruby
# rvm install ruby-2.3.0-dev
# 
# gem install bundler execjs therubyracer

echo "Downloading Golang and drive client"
wget https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go*.tar.gz

go get -u github.com/odeke-em/drive/cmd/drive
go get github.com/odeke-em/drive/drive-gen && drive-gen

# install anaconda
echo "Installing Anaconda"
wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
bash Anaconda*.sh

pip install powerline-status powerline-gitstatus glances

# now install texlive
echo "Installing TexLive distribution"
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
./install-tl

echo "Hopefully TeXLive worked as expected"

# now install 


# setup dotfiles
echo "Setting up dotfiles"
./dotfiles/install

# set TeXLive paper size
tlmgr paper letter
