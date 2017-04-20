#!/usr/bin/env bash
# trap functions to delete temporary folder on exit
# find directory of script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# create a temp directory inside $DIR
WORK_DIR='mktemp -d -p "$DIR"'

# make sure tmp dir was actually created
if [[ ! "$WORK_DIR" || -d "$WORK_DIR" ]]; then
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
########################################################################
# list of packages to download for linux

# anaconda version
anaconda_version="4.3.1"
anaconda_hash="4447b93d2c779201e5fb50cfc45de0ec96c3804e7ad0fe201ab6b99f73e90302"

# go lang source
go_version="1.8.1"
go_hash="a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994"

apt_packages=(
    exuberant-ctags
    git
    myrepos
    tmux
    zsh
    vim-gtk
    zathura
    zathura-dev
    xdotool
    redshift-gtk
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

install_packages () {
    cmd="sudo apt-get -y install"
    shift
    for pkg in "${apt_packages[@]}";
    do
        exec="$cmd ${pkg}"
        prompt "Execute: $exec" "${exec}"
    done    
}

######################################## Functions #############################################
# install graphics drivers

echo "We're going to update and install a bunch of stuff"
sudo apt-get -y update
prompt "Add NVIDIA driver repo" "sudo add-apt-repository ppa:graphics-drivers/ppa"

# download packages
prompt "Install packages" "install_packages"
# check and then install chrome
if command_exists google-chrome; then
    echo "Google Chrome already installed"
else
    echo "Chrome not installed"
    prompt "Download Google Chrome" "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $HOME/google_chrome.deb"
    prompt "Install Google Chrome" "sudo dpkg -i $HOME/google_chrome.deb"
fi

# install anaconda
if [[ ! -d "$HOME/anaconda3" ]]; then
    echo "Anaconda is not installed"

    prompt "Download Anaconda install script" "wget https://repo.continuum.io/archive/Anaconda3-${anconda_version}-Linux-x86_64.sh -O $WORK_DIR/anaconda.sh"

    if [ ! sha256sum -c <<< "${anaconda_hash} ${WORK_DIR}/anaconda.sh" ]; then
        echo "Hash does not match. Aborting!"
        exit 1
    else
        echo "Hash match. Installing Anaconda"
        prompt "Install Anaconda" "bash ${WORK_DIR}/anaconda.sh -b -p ${HOME}/anaconda3"
    fi
else
    echo "Anaconda is already installed"
fi

# install the go language
if [[ ! -d "/usr/local/go" ]]; then
    echo "Golang is not installed"

    prompt "Download Golang install binary" "wget https://storage.googleapis.com/golang/go${go_version}.linux-amd64.tar.gz -O $WORK_DIR/go.tar.gz"

    if [ ! sha256sum -c <<< "${go_hash} ${WORK_DIR}/go.tar.gz" ]; then
        echo "Hash does not match. Aborting!"
        exit 1
    else
        echo "Hash match. Installing Golang"
        prompt "Install Golang" "tar -c /usr/local -xzf $WORK_DIR/go.tar.gz"
    fi
else
    echo "Golang is already installed"
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

if [[ -d "$HOME/Documents/system_setup)" ]]; then
    echo "System setup repo already exits"
    prompt "Update the repo" "(cd $HOME/Documents/system_setup && git submodule init && git submodule update --recursive --remote)"
    prompt "Install the dotfiles" "(cd $HOME/Documents/system_setup/dotfiles && ./install linux)"
else
    echo "System setup repo does not exist"

    prompt "Clone system_setup repo" "git clone git@github.com:skulumani/system_setup.git $HOME/Documents/system_setup"
    echo "Now we'll update the submodules and install all the dotfiles"
    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup && git submodule init && git submodule update --recursive --remote && ./dotfiles/install linux)"
fi

# make sure Anaconda is on the path
echo "Now make sure you're using the correct version of Anaconda"
echo "Source all the profile scripts"
source ~/.profile
source ~/.bashrc
python --version

# install drive client
echo "Installing Google Drive client"
prompt "Install drive client" "go get -u github.com/odeke-em/drive/cmd/drive"
prompt "Test drive client" "drive --version"

echo "Install all the pip packages"
prompt "Install pip packages" "install_pips"

# setup zsh as default
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

prompt "Install oh-my-zsh" "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"
echo "All finished"
exit
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
