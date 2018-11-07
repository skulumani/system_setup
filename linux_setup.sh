#!/usr/bin/env bash
# trap functions to delete temporary folder on exit
# find directory of script
DIR="$HOME"

# create a temp directory inside $DIR
WORK_DIR=$(mktemp -d -p "$DIR")

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

# anaconda version
anaconda_version="5.0.0"
anaconda_hash="67f5c20232a3e493ea3f19a8e273e0618ab678fa14b03b59b1783613062143e9"

# go lang source
go_version="1.8.1"
go_hash="a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994"

texlive_year="2018"

apt_packages=(
    exuberant-ctags
    git
    myrepos
    zsh
    zathura
    zathura-dev
    xdotool
    redshift-gtk
    trash-cli
    software-properties-common
    gnome-terminal
    conky-all
    curl
    lm-sensors
    hddtemp
    clang
    gnupg2 
    pcscd
    scdaemon
    gnupg-agent
    yubikey-personalization
    pinentry-curses
)

python_packages=(
    neovim
    neovim-remote
)
######################################## End of app list ########################################
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
    prompt "Download Google Chrome" "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O $WORK_DIR/google_chrome.deb"
    prompt "Install Google Chrome" "sudo dpkg -i $WORK_DIR/google_chrome.deb"

    prompt "Fix the Chrome dependencies" "sudo apt-get -y install -f"
fi

# install neovim
if command_exists nvim; then
    echo "NeoVim already installed"
else
    echo "Neovim not installed"
    prompt "Do you want to add Neovim Ubuntu repo" "sudo add-apt-repository -y ppa:neovim-ppa/stable && sudo apt-get -y update"
    prompt "Do you want to install Neovim" "sudo apt-get -y install neovim"
fi

# install anaconda
if [[ ! -d "$HOME/anaconda3" ]]; then
    echo "Anaconda is not installed"
    prompt "Download Anaconda install script" "wget https://repo.continuum.io/archive/Anaconda3-${anaconda_version}-Linux-x86_64.sh -O $WORK_DIR/anaconda.sh"

    if ! sha256sum -c <<< "$anaconda_hash  $WORK_DIR/anaconda.sh"; then
        echo "Hash does not match. Aborting!"
        exit 1
    else
        echo "Hash match. Installing Anaconda"
        prompt "Install Anaconda" "bash ${WORK_DIR}/anaconda.sh -b -p $HOME/anaconda3"
    fi
else
    echo "Anaconda is already installed"
fi

# install texlive
if [[ ! -d "/usr/local/texlive/$texlive_year" ]]; then
    echo "TeXlive is not installed"
    prompt "Download texlive installer" "wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O $WORK_DIR/install-tl.tar.gz"
    eval "tar -C $WORK_DIR -xzf $WORK_DIR/install-tl.tar.gz"
    
    prompt "Create TeXLive directory and set correct permissions" "sudo mkdir -p /usr/local/texlive/$texlive_year; sudo chown -R $USER: /usr/local/texlive/; sudo chmod -R u+rw /usr/local/texlive"
    prompt "Install TeXlive" "$WORK_DIR/install-tl-*/install-tl"
else
    echo "TexLive is already installed"
fi

# install the go language
if [[ ! -d "/usr/local/go" ]]; then
    echo "Golang is not installed"

    prompt "Download Golang install binary" "wget https://storage.googleapis.com/golang/go${go_version}.linux-amd64.tar.gz -O $WORK_DIR/go.tar.gz"

    if ! sha256sum -c <<< "${go_hash} ${WORK_DIR}/go.tar.gz"; then
        echo "Hash does not match. Aborting!"
        exit 1
    else
        echo "Hash match. Installing Golang"
        prompt "Install Golang" "sudo tar -C /usr/local -xzf $WORK_DIR/go.tar.gz"
    fi
else
    echo "Golang is already installed"
fi

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
echo "Now we're going to install Boinc if desired"
prompt "Install Boinc-client and Manger" "sudo apt-get install boinc-client boinc-manager"
prompt "Install Boinc-client headless mode" "sudo apt-get install boinc-client && boinccmd --join_acct_mgr bam.boincstats.com 9339_bd290f245f79b42e8672e1a077c14f48 random"

# setup system_setup repo and install dotfiles
echo "Now we'll setup git and clone the dotfiles repository"

if [[ -d "$HOME/Documents/system_setup" ]]; then
    echo "System setup repo already exits"
    prompt "Update the repo" "(cd $HOME/Documents/system_setup && git submodule init && git submodule update --recursive --remote)"
    prompt "Install the dotfiles" "(cd $HOME/Documents/system_setup/dotfiles && ./install linux)"
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
    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup && git submodule init && git submodule update --recursive --remote && ./dotfiles/install linux)"
fi

# make sure Anaconda is on the path
echo "Now make sure you're using the correct version of Anaconda"
echo "Add Anaconda and Golang to the path"
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/anaconda3/bin:"$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/texlive/${texlive_year}/bin/x86_64-linux:$PATH

prompt "Test Anaconda" "python --version"

prompt "Install Neovim2 and Neovim3 anaconda env" "conda-env create -f ~/Documents/system_setup/conda/neovim2.yml && conda-env create -f ~/Documents/system_setup/conda/neovim3.yml"

prompt "Test Golang" "go --version"

# install drive client
echo "Installing Google Drive client"
if command_exists drive; then 
    echo "drive client already installed"
else
    prompt "Install drive client" "go get -u github.com/odeke-em/drive/cmd/drive"
fi

prompt "Test drive client" "drive --version"

prompt "Set correct TeX paper size" "tlmgr paper letter"
prompt "Update TeXLive" "tlmgr update --list; tlmgr update --all"

echo "Install all the pip packages"
prompt "Install pip packages" "install_pips"

# setup zsh as default
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

prompt "Install oh-my-zsh" "git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh"

# build custom versions of apps
prompt "Build TMUX" "bash ~/Documents/system_setup/build_tmux.sh"
prompt "Build ag" "bash ~/Documents/system_setup/build_ag.sh"

prompt "Enable SSH server" "sudo apt-get install openssh-server && sudo service ssh restart"

echo "All finished"
echo "Might need to restart and rerun dotfiles/install linux to make sure eerything is working"
