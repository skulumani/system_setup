#!/usr/bin/env bash

DIR="$HOME"
WORK_DIR=$(mktemp -d -t "tempdir")

# make sure tmp dir was actually created
if [[ ! -d "$WORK_DIR" ]]; then
    echo "Could not create temp directory"
    exit 1
fi

# delete temp dir
cleanup () {
    rm -rf "$WORK_DIR"
    echo "Deleted temp working directory: $WORK_DIR"
}

# register cleanup function to be called on exit
trap cleanup EXIT

###############################################################################
# anaconda version
anaconda_version="5.0.0"
anaconda_hash="23df1e3a38a6b4aaa0ab559d0c1e51be76eca5d75cb595d473d223c8d17e762d"

brews=(
    ctags
    git
    go
    myrepos
    tmux
    zsh
    neovim/neovim/neovim
    the_silver_searcher
    trash-cli
    wget
    ripgrep
)

casks=(
    appcleaner
    caffeine
    coconutbattery
    google-chrome
    mactex
    iterm2
    skim
    vlc
    xquartz
    tunnelblick
    jabref
)

python_packages=(
    glances
    neovim
    neovim-remote
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

command_exists () {
    type "$1" > /dev/null; 
}

install_homebrew () {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_brews () {
    cmd="brew install"
    for pkg in "${brews[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}
install_casks () {
    cmd="brew cask install"
    shift
    for pkg in "${casks[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}

install_pips () {
    cmd="pip install"
    shift
    for pkg in "${python_packages[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}
install_ohmyzsh () {
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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
if ! command_exists brew; then
    echo "Homebrew is not installed"
    prompt "Install Homebrew" install_homebrew
else
    echo "Homebrew is already installed"
    prompt "Update Homebrew" "brew update; brew update; brew upgrade; brew doctor"
fi

# install brew casks
prompt "Install brew casks" "install_casks"

prompt "Install brews" "install_brews"

# install anaconda
if [[ -d "$HOME/anaconda3" ]]; then
    echo "Anaconda already installed"
else
    echo "We're going to install Anaconda using Homebrew"
    prompt "Download Anaconda install script" "wget https://repo.continuum.io/archive/Anaconda3-${anaconda_version}-MacOSX-x86_64.sh -O $WORK_DIR/anaconda.sh"
    
    if ! shasum -a 256 -c <<< "$anaconda_hash  $WORK_DIR/anaconda.sh"; then
        echo "Hash does not match. Aborting!"
        exit 1
    else
        echo "Hash match. Installing Anaconda"
        prompt "Install Anaconda" "bash ${WORK_DIR}/anaconda.sh -b -p $HOME/anaconda3"
    fi
fi

# setup ssh 
echo "Now setup SSH keys so we can clone our Git repos"
if [[ -d "$HOME/.ssh" ]]; then
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

if [[ -d "$HOME/Documents/system_setup" ]]; then
    echo "System setup repo already exits"
    prompt "Update the repo" "(cd $HOME/Documents/system_setup &&  git submodule init && git submodule update --recursive --remote)"
    prompt "Install the dotfiles" "(cd $HOME/Documents/system_setup/dotfiles && ./install mac)"
else
    echo "System setup repo does not exist"

    prompt "Clone system_setup repo" "git clone git@github.com:skulumani/system_setup.git $HOME/Documents/system_setup"
    echo "Now we'll update the submodules and install all the dotfiles"
    if [[ -f "$HOME/.profile" ]]; then
        mv $HOME/.profile $HOME/.profile_backup
    fi

    if [[ -f "$HOME/.bashrc" ]]; then
        mv $HOME/.bashrc $HOME/.bashrc_backup
    fi

    if [[ -f "$HOME/.bashrc" ]]; then
        mv $HOME/.zshrc $HOME/.zshrc_backup
    fi
    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup &&  git submodule init && git submodule update --recursive --remote && ./dotfiles/install mac)"
fi

# make sure Anaconda is on the path
echo "Now make sure you're using the correct version of Anaconda"
echo "Add Anaconda and Golang to the path"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/anaconda3/bin:"$PATH"
export PATH=$PATH:/usr/local/go/bin

prompt "Test Anaconda" "python --version"
prompt "Test Golang" "go --version"

# install vim with python support
prompt "Install vim" "brew install vim --with-client-server --with-override-system-vi --with-python3"

# install drive client
echo "Installing Google Drive client"
if command_exists drive; then 
    echo "drive client already installed"
else
    prompt "Install drive client" "go get -u github.com/odeke-em/drive/cmd/drive"
fi

prompt "Test drive client" "drive --version"

echo "Install all the pip packages"
prompt "Install pip packages" "install_pips"


# setup zsh as default
echo "Now set zsh as the default shell"
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

prompt "Install oh-my-zsh" "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
echo "All finished"
echo "Might need to restart and rerun dotfiles/install mac to make sure eerything is working"
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
