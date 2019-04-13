#!/bin/bash -xv
# vim: set ts=4 sw=4 sts=4 et:

# trap functions to delete temporary folder on exit
# find directory of script
DIR="$HOME"
    
# create a temp directory inside $DIR
WORK_DIR=$(mktemp -d -p "$DIR")
CURRENT_DIR=$(pwd)

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
########################################################################
# list of packages to download for linux
apt_packages=(
    exuberant-ctags
    git
    zsh
    zathura
    zathura-dev
    xdotool
    redshift-gtk
    trash-cli
    software-properties-common
    conky-all
    curl
    lm-sensors
    hddtemp
    synaptic
    vim
    tmux
)

# Old packages that might be useful
# myrepos
# gnome-terminal

# miniconda version
anaconda_version="5.0.0"
anaconda_hash="67f5c20232a3e493ea3f19a8e273e0618ab678fa14b03b59b1783613062143e9"

miniconda_path="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
miniconda_hash="866ae9dff53ad0874e1d1a60b1ad1ef8" # md5sum

# use an ubuntu package instead
texlive_year="2018"

python_packages=(
    neovim
    neovim-remote
)

######################################## End of app list ########################################
################# FUNCTIONS ################################################## 
set +e
options=("Yes" "No" "Quit")
prompt () {
    echo "Are you sure you want to $1"
    select yn in "${options[@]}"; do
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
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}

install_packages () {
    cmd="sudo apt-get -y install"
    shift
    for pkg in "${apt_packages[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}

install_amd_driver () {
    echo "Are you sure you want to update AMD drivers?"
    read -p "Press enter to continue"
    
    sudo add-apt-repository ppa:paulo-miguel-dias/pkppa
    sudo apt dist-upgrade
    sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386
}

install_nvidia_driver () {
    prompt "Add NVIDIA driver repo" "sudo add-apt-repository ppa:graphics-drivers/ppa"
}

install_texlive_directly () {
    if [[ ! -d "/usr/local/texlive/$texlive_year" ]]; then
        echo "TeXlive is not installed"
        prompt "Download texlive installer" "wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O $WORK_DIR/install-tl.tar.gz"
        eval "tar -C $WORK_DIR -xzf $WORK_DIR/install-tl.tar.gz"

        prompt "Create TeXLive directory and set correct permissions" "sudo mkdir -p /usr/local/texlive/$texlive_year; sudo chown -R $USER: /usr/local/texlive/; sudo chmod -R u+rw /usr/local/texlive"
        prompt "Install TeXlive" "$WORK_DIR/install-tl-*/install-tl"
    else
        echo "TexLive is already installed"
    fi

    export PATH=/usr/local/texlive/${texlive_year}/bin/x86_64-linux:$PATH
    tlmgr paper letter
    tlmgr update --list; tlmgr update --all
}

install_miniconda () {
    if [[ ! -d "$HOME/anaconda3" ]]; then
        echo "Anaconda is not installed"
        prompt "Download Miniconda install script" "wget ${miniconda_path} -O $WORK_DIR/anaconda.sh"

        if ! md5sum -c <<< "$miniconda_hash  $WORK_DIR/anaconda.sh"; then
            echo "Hash does not match. Aborting!"
            exit 1
        else
            echo "Hash match. Installing Anaconda"
            prompt "Install Anaconda" "bash ${WORK_DIR}/anaconda.sh -b -p $HOME/anaconda3"
        fi
    else
        echo "Anaconda is already installed"
    fi

    export PATH=$HOME/anaconda3/bin:"$PATH"
    echo "Make sure Python is actually using Anaconda"
    python --version
    read -p "Press Enter to continue"
     
    prompt "Install Neovim2 and Neovim3 anaconda env" "conda-env create -f ~/Documents/system_setup/conda/neovim2.yml && conda-env create -f ~/Documents/system_setup/conda/neovim3.yml"
}

install_google_chrome () {

    if command_exists google-chrome; then
        echo "Google Chrome already installed"
    else
        echo "Chrome not installed"
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $WORK_DIR/google_chrome.deb
        sudo dpkg -i $WORK_DIR/google_chrome.deb
        # prompt "Fix the Chrome dependencies" "sudo apt-get -y install -f"
    fi
}

install_neovim () {
    neovim_version="0.3.4"
    neovim_path="https://github.com/neovim/neovim/releases/download/v${neovim_version}/nvim.appimage"

    if command_exists nvim; then
        echo "NeoVim already installed"
    else
        echo "Neovim not installed"
        wget ${neovim_path} -O $HOME/bin/nvim
        chmod u+x $HOME/bin/nvim
        #prompt "Do you want to add Neovim Ubuntu repo" "sudo add-apt-repository -y ppa:neovim-ppa/stable && sudo apt-get -y update"
        #prompt "Do you want to install Neovim" "sudo apt-get -y install neovim"
    fi
}

install_yubikey () {
    sudo apt-get install gnupg2 gnupg-agent pcscd pinentry-curses scdaemon
    sudo ln -s /usr/bin/pinentry-curses /usr/local/bin/pinentry-curses
    echo "Now download my public key"
    curl https://keybase.io/skulumani/pgp_keys.asc | gpg --import
    echo "Now set the trust level of the key"
    echo "Enter gpg> trust, followed by save, and then quit"
    gpg --edit-key 0x20D0685093466FC7
    echo "Test the Yubikey - plug it in"
    read -p "Press Enter when Yubikey is available"
    gpg --card-status
    echo "You should see something like sec# and the yubikey information"
    read -p "Press enter to continue"
}

install_dotfiles () {

    if [[ -d "$HOME/Documents/system_setup" ]]; then
        echo "System setup repo already exits"
        cd $HOME/Documents/system_setup 
        git submodule init  
        git submodule update --recursive --remote
        echo "Now installing the dotfiles"
        bash install_profile.sh ubuntu
	cd $CURRENT_DIR
    else
        echo "System setup repo does not exist"
        echo "Now cloning from Github"

        git clone https://github.com/skulumani/system_setup.git $HOME/Documents/system_setup
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
        echo "Now installing the dotfiles"

	cd $HOME/Documents/system_setup
        git submodule init  
        git submodule update --recursive --remote
        bash install_profile.sh ubuntu
	echo "Now change the remote back to using ssh for yubikey"
	git remote set-url origin git@github.com:skulumani/systems_setup.git
	cd $CURRENT_DIR
    fi
}

install_zsh () {
    echo "Set default shell"
    chsh -s $(which zsh)
    
    echo "Setup oh my zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
}

######################################## INSTALLATION ##########################
# install graphics drivers

echo "We're going to update and install a bunch of stuff"
echo "There are echo statements along the way and PROMPTS"
echo "This is interactive!!!"
echo " "

prompt "Update packages" "sudo apt-get -y update"

# AMD Driver
prompt "Install AMD PPA and drivers" "install_amd_driver"
# prompt "Install NVIDIA PPA" "install_nvidia_driver"

# download packages
prompt "Install packages" "install_packages"

prompt "Setup Yubikey" "install_yubikey"

# setup system_setup repo and install dotfiles
echo "Now we'll setup git and clone the dotfiles repository"
prompt "Setup dotfiles" "install_dotfiles"

# check and then install chrome
prompt "Install Google Chrome" "install_google_chrome"

# install neovim by copying the appimage
prompt "Install NeoVim" "install_neovim"

# install anaconda
prompt "Install latest Miniconda" "install_miniconda"

# install texlive
prompt "Install TexLive $texlive_year directly" "install_texlive_directly"

# setup zsh as default
prompt "Setup zsh" "install_zsh"

# build custom versions of apps
# prompt "Enable SSH server" "sudo apt-get install openssh-server && sudo service ssh restart"

echo "All finished"
echo "Might need to restart and rerun dotfiles/install linux to make sure eerything is working"

# install the go language
# if [[ ! -d "/usr/local/go" ]]; then
#     echo "Golang is not installed"

#     prompt "Download Golang install binary" "wget https://storage.googleapis.com/golang/go${go_version}.linux-amd64.tar.gz -O $WORK_DIR/go.tar.gz"

#     if ! sha256sum -c <<< "${go_hash} ${WORK_DIR}/go.tar.gz"; then
#         echo "Hash does not match. Aborting!"
#         exit 1
#     else
#         echo "Hash match. Installing Golang"
#         prompt "Install Golang" "sudo tar -C /usr/local -xzf $WORK_DIR/go.tar.gz"
#     fi
# else
#     echo "Golang is already installed"
# fi

# setup ssh 
# echo "Now setup SSH keys so we can clone our Git repos"
# if [[ -d "$HOME/.ssh" ]]; then
#     echo "$HOME/.ssh exists - using keys that are there"
#     eval "$(ssh-agent -s)"
#     prompt "Add ssh keys" "ssh-add ~/.ssh/id_rsa"
    
#     prompt "Display ~/.ssh/id_rsa.pub" "cat ~/.ssh/id_rsa.pub"
#     echo "Copy the default SSH key and input it into Github/Bitbucket"
# else
#     echo "Create new ssh keys"

#     prompt "Create new ssh keys" "ssh-keygen -t rsa -b 4096 -C 'shanks.k@gmail.com'"
#     prompt "Start the ssh-agen" "eval '$(ssh-agent -s)'"
#     prompt "Add ssh key" "ssh-add ~/.ssh/id_rsa"
    
#     prompt "Copy the default key to terminal" "cat ~/.ssh/id_rsa.pub"
#     echo "Copy the default SSH key and input it into Github/Bitbucket"
# fi

# Now we'll setup Boinc
# echo "Now we're going to install Boinc if desired"
# prompt "Install Boinc-client and Manger" "sudo apt-get install boinc-client boinc-manager"
# prompt "Install Boinc-client headless mode" "sudo apt-get install boinc-client && boinccmd --join_acct_mgr bam.boincstats.com 9339_bd290f245f79b42e8672e1a077c14f48 random"


# make sure Anaconda is on the path
# export GOPATH=$HOME/.go
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:/usr/local/go/bin

# prompt "Test Golang" "go --version"

# TODO Use the ubuntu package instead install drive client
# echo "Installing Google Drive client"
# if command_exists drive; then 
#     echo "drive client already installed"
# else
#     prompt "Install drive client" "go get -u github.com/odeke-em/drive/cmd/drive"
# fi

# prompt "Test drive client" "drive --version"


# echo "Install all the pip packages"
# prompt "Install pip packages" "install_pips"

