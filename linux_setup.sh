#!/usr/bin/env bash
# list of packages to download for linux

# anaconda version
anaconda_version="4.3.1"
anaconda_hash="4447b93d2c779201e5fb50cfc45de0ec96c3804e7ad0fe201ab6b99f73e90302"

brews=(
    ctags
    git
    go
    myrepos
    tmux
    zsh
)

python_packages=(
    powerline-status
    powerline-gitstatus
    glances
)
######################################## End of app list ########################################
set +e
options=("Yes" "No" "Quit")
prompt () {
    echo "Are you sure you want to $1"
    select yn in "${options[@])}"; do
        case $yn in
            Yes ) eval "$2";
                break;;
            No ) break;;
            Quit ) exit;;
        esac
    done
}
command_exists () {
command -v "$1" >/dev/null 2>&1 ;
}

install_pips () {
    cmd="pip install"
    shift
    for pkg in "${python_packages[@]}";
    do
        exec="$cmd ${pkg}"
        prompt "Execute: $exec" "${exec}"
    done    
}

install_anaconda () {
    if [ ! -d "$HOME/anaconda3" ]; then
        echo "Anaconda is not installed"
        prompt "Download Anaconda install script" "wget https://repo.continuum.io/archive/Anaconda3-${anconda_version}-Linux-x86_64.sh -O $HOME/anaconda.sh"
        
        if [ ! sha256sum -c <<< "$anaconda_hash anaconda.sh" ]; then
            echo "Hash does not match. Aborting!"
            exit 1
        else
            echo "Hash match. Installing"
            prompt "Install Anaconda" "bash $HOME/anaconda.sh -b -p $HOME/anaconda3"
        fi
}
install_chrome () {
sudo dpkg -i google-chrome*.deb


}
######################################## Functions #############################################
# check and then install chrome
if command_exists google-chrome; then
    echo "Google Chrome already installed"
else
    echo "Chrome not installed"
    prompt "Download Google Chrome" "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $HOME/google_chrome.deb"
    prompt "Install Google Chrome" "sudo dpkg -i $HOME/google_chrome.deb"
fi

# install anaconda
echo "We're going to install Anaconda using Homebrew"
prompt "Install Anaconda" "brew cask install anaconda"

# setup ssh 
echo "Now setup SSH keys so we can clone our Git repos"
if [ -d "$HOME/.ssh" ]; then
    echo "~/.ssh exists - using keys that are there"
    eval "$(ssh-agent -s)"
    prompt "Add ssh keys" "ssh-add ~/.ssh/id_rsa"
    
    prompt "Display ~/.ssh/id_rsa.pub" "cat ~/.ssh/id_rsa.pub"
    echo "Copy the default SSH key and input it into Github/Bitbucket"
else
    echo "Create new ssh keys"

    prompt "Create new ssh keys" "ssh-keygen -t rsa -b 4096 -C 'shanks.k@gmail.com'"
    prompt "Start the ssh-agen" "eval '$(ssh-agent -s)'"
    prompt "Add ssh key" "ssh-add ~/.ssh/id_rsa"
    
    prompt "Copy the default key to terminal" "cat ~/.ssh/id_rsa.pub"
    echo "Copy the default SSH key and input it into Github/Bitbucket"
fi

# setup system_setup repo and install dotfiles
echo "Now we'll setup git and clone the dotfiles repository"
prompt "Install git" "brew install git"

if [ -d "$HOME/Documents/system_setup)" ]; then
    echo "System setup repo already exits"
    prompt "Update the repo" "(cd $HOME/Documents/system_setup &&  git submodule init && git submodule update --recursive --remote)"
    prompt "Install the dotfiles" "(cd $HOME/Documents/system_setup/dotfiles && ./install mac)"
else
    echo "System setup repo does not exist"

    prompt "Clone system_setup repo" "git clone git@github.com:skulumani/system_setup.git $HOME/Documents/system_setup"
    echo "Now we'll update the submodules and install all the dotfiles"
    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup &&  git submodule init && git submodule update --recursive --remote && ./dotfiles/install mac)"
fi

# make sure Anaconda is on the path
echo "Now make sure you're using the correct version of Anaconda"
echo "Source all the profile scripts"
source ~/.profile
source ~/.bashrc
python --version

# install vim with python support
prompt "Install vim" "brew install vim --with-client-server --with-override-system-vi --with-python3"

# install drive client
echo "Installing Google Drive client"
go get -u github.com/odeke-em/drive/cmd/drive

echo "Install all the pip packages"
prompt "Install pip packages" "install_pips"

# setup zsh as default
echo "Now set zsh as the default shell"
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

echo "All finished"
# install brews

# prompt "Update ruby"
# ruby -v
# brew install gpg
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash -s stable
# ruby_version='2.6.0'
# rvm install ${ruby_version}
# rvm use ${ruby_version} --default
# ruby -v
# sudo gem update --system
# 
# prompt "Install Java"
# brew cask install java
# 
# prompt "Install packages"
# brew info ${brews[@]}
# install 'brew install' ${brews[@]}
# 
# prompt "Install software"
# brew tap caskroom/versions
# brew cask info ${casks[@]}
# install 'brew cask install' ${casks[@]}
# 
# prompt "Installing secondary packages"
# install 'pip install --upgrade' ${pips[@]}
# install 'gem install' ${gems[@]}
# install 'npm install --global' ${npms[@]}
# install 'apm install' ${apms[@]}
# install 'code --install-extension' ${vscode[@]}
# brew tap caskroom/fonts
# install 'brew cask install' ${fonts[@]}
# 
# prompt "Upgrade bash"
# brew install bash
# sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
# mv ~/.bash_profile ~/.bash_profile_backup
# mv ~/.bashrc ~/.bashrc_backup
# mv ~/.gitconfig ~/.gitconfig_backup
# cd; curl -#L https://github.com/barryclark/bashstrap/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,screenshot.png}
# #source ~/.bash_profile
# 
# prompt "Set git defaults"
# for config in "${git_configs[@]}"
# do
#   git config --global ${config}
# done
# gpg --keyserver hkp://pgp.mit.edu --recv ${gpg_key}
# 
# prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"
# 
# prompt "Update packages"
# pip3 install --upgrade pip setuptools wheel
# mac update
# 
# prompt "Cleanup"
# brew cleanup
# brew cask cleanup
# 
# read -p "Run `mackup restore` after DropBox has done syncing ..."
# echo "Done!"
