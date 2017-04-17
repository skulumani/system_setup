#!/usr/bin/env bash

brews=(
    ctags
    gig
    git
    go
    myrepos
    tux
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

fonts=(
  font-source-code-pro
)

######################################## End of app list ########################################
set +e

prompt () {
    echo "Are you sure you want to $1"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) eval "$2";
                break;;
            No ) break;;
        esac
    done
}

install_homebrew () {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_brew () {
    cmd="brew install"
    for pkg in "${brews[@]}";
    do
        exec="$cmd ${pkg}"
        prompt "Execute: $exec" "${exec}"
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

# install brew casks
prompt "Install brew casks" "install_casks"
# check and setup ssh
echo "Now we're going to check and setup SSH keys for Github and BB"

# clone system_setup repo and install dot files
echo "Now we'll clone our system setup repo and install dotfiles"
git clone 
# download powerline for anaconda pip
# download vim after setting up anaconda path


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
