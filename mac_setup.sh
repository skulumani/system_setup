#!/usr/bin/env bash

brews=(
    ctags
    git
    go
    myrepos
    tmux
    "vim --with-client-server --with-override-system-vi --with-python3"
    zsh
)

casks=(
    anaconda
    appcleaner
    caffeine
    coconutbattery
    google-chrome
    iterm2
    skim
    tunnelbear
    vlc
    xquartz
)

python_packages=(
    powerline-status
    powerline-gitstatus
    glances
)

fonts=(
  font-source-code-pro
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

install_homebrew () {
    echo "Install ruby"
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_brew () {
    cmd="brew install"
    for pkg in "${brews[@]}";
    do
        exec="$cmd ${pkg}"
        echo "$exec"
        # prompt "Execute: $exec" "${exec}"
    done    
}
install_casks () {
    cmd="brew cask install"
    shift
    for pkg in "${casks[@]}";
    do
        exec="$cmd ${pkg}"
        echo "$exec"
        # prompt "Execute: $exec" "${exec}"
    done    
}

install_pips () {
    cmd="pip install"
    shift
    for pkg in "${python_packages[@]}";
    do
        exec="$cmd ${pkg}"
        echo "$exec"
        # prompt "Execute: $exec" "${exec}"
    done    
}
######################################## Functions #############################################
# test if xcode is already installed
if test ! $(xcode-select -p); then
    echo "xcode not installed."
    prompt "Install Xcode" "xcode-select --install"
else
    echo "xcode is already installed"
fi

# test if homebrew is already installed
if test ! $(which brew); then
    echo "Homebrew is not installed"
    prompt "Install Homebrew" install_homebrew
else
    echo "Homebrew is already installed"
    prompt "Update Homebrew" "brew update; brew update; brew upgrade; brew doctor"
fi

# install anaconda
echo "We're going to install Anaconda using Homebrew"
prompt "Install Anaconda" "brew cask install anaconda"

# setup ssh 
echo "Now setup SSH keys so we can clone our Git repos"
if [ "$(ls -A $HOME/.ssh)" ]; then
    echo "~/.ssh exists - using keys that are there"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
    cat ~/.ssh/id_rsa.pub
    echo "Copy the default SSH key and input it into Github/Bitbucket"
else
    echo "Create new ssh keys"

    ssh-keygen -t rsa -b 4096 -C "shanks.k@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
    cat ~/.ssh/id_rsa.pub
    echo "Copy the default SSH key and input it into Github/Bitbucket"
fi

# setup system_setup repo and install dotfiles
echo "Now we'll setup git and clone the dotfiles repository"
prompt "Install git" "brew install git"

prompt "Clone system_setup repo" "git clone git@github.com:skulumani/system_setup.git $HOME/Documents/system_setup"
echo "Now we'll update the submodules and install all the dotfiles"
prompt "Install dotfiles" "(cd $HOME/Documents/system_setup &&  git submodule init && git submodule update --recursive --remote && ./dotfiles/install)"

# make sure Anaconda is on the path
echo "Now make sure you're using the correct version of Anaconda"
source ~/.bashrc
python --version

echo "Install all the pip packages"
prompt "Install pip packages" "install_pips"

# install brew casks
prompt "Install brew casks" "install_casks"

prompt "Install brews" "install_brews"

# setup zsh as default
echo "Now set zsh as the default shell"
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

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
