# !/bin/bash

dotfiles=".gitignore_global .mrconfig .gitconfig .driverc"
# add repos
# install NVIDIA graphics drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
# sublime text 3
sudo add-apt-repository ppa:webupd8team/sublime-text-3
# drive client
sudo add-apt-repository ppa:twodopeshaggy/drive
# download latest Texlive and update



# basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

sudo apt-get install google-chrome-stable
sudo apt-get install sublime-text-installer

sudo apt-get install golang
sudo apt-get install drive
sudo apt-get install myrepos

# Need to setup SSH keys prior to downloading repos

# Setup Sublime Text 3
# install packagecontrol
echo "Now setting up Sublime Text 3 for all your text editing needs!"
echo "First we download Package control"

wget https://packagecontrol.io/Package%20Control.sublime-package -O "~/.config/sublime-text-3/Installed Packages"

# now clone our Sublime Text settings 
echo "Now we clone our sublime text settings"
git clone git@github.com:skulumani/sublime_settings.git ~/.config/sublime-text-3/Packages/User/

# now test sublime text 3
echo "Now open Sublime Text and make sure it works"

subl -n

# clone texmf tree


# symbolic links for dot files 
echo "Creating dot file links"
echo "Changing directory"
cd ./dotfiles

echo "Now in dotfiles directory"

for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -s ./$file ~/$file
done

echo "Finished all dotfiles"
