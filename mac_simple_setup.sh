#!/usr/bin/env bash

DIR="$HOME"
WORK_DIR=$(mktemp -d -t "tempdir")

# make sure tmp drive is created
if [[ ! -d "$WORK_DIR" ]]; then
    echo "Could not create temp directory"
    exit 1
fi

# delete temp dir
cleanup () {
    rm -rf "$WORK_DIR"
    echo "Deleted temp working directory: $WORK_DIR"
}

trap cleanup EXIT

###########################################################
brews=(
    ctags
    tmux
    neovim
    ripgrep
    wget
)

casks=(
    iterm2
)

fonts=(
    font-source-code-pro
)
###########################################################

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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_brews () {
    cmd="brew install"
    for pkg in "${brews[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute $exec" "${exec}"
    done
}

install_casks () {
    cmd="brew install --cask"
    shift
    for pkg in "${casks[@]}";
    do
        exec="$cmd ${pkg}"
        eval "${exec}"
        # prompt "Execute: $exec" "${exec}"
    done    
}

install_ohmyzsh () {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

###########################################
# test if xcode is already installed
if test ! $(xcode-select -p); then
    echo "xcode not installed."
    prompt "Install Xcode" "xcode-select --install"
else
    echo "xcode is already installed"
fi

i# test if homebrew is already installed
if ! command_exists brew; then
    echo "Homebrew is not installed"
    prompt "Install Homebrew" install_homebrew
else
    echo "Homebrew is already installed"
    prompt "Update Homebrew" "brew update; brew update; brew upgrade; brew doctor"
fi

prompt "Install brews" "install_brews"
prompt "Install casks" "install_casks"

echo "Now will install dotfiles"

if [[ -d "$HOME/Documents/system_setup" ]]; then
    echo "$Home/Documents/system_setup already exists"
    prompt "Update system_setup" "(cd $HOME/Documents/system_setup && git submodule init && git submodule update --recursive --remote)"
    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup && ./install mac_simple)"
else
    echo "system_setup repo does not exist"

    prompt "CLone system_setup repo" "git clone git@github.com:skulumani/system_setup.git $HOME/Documents/system_setup"
    echo "Update submodules and install dotfiles"

    if [[ -f "$HOME/.profile" ]]; then
        mv $HOME/.profile $HOME/.profile_backup
    fi

    if [[ -f "$HOME/.bashrc" ]]; then
        mv $HOME/.bashrc $HOME/.bashrc_backup
    fi

    if [[ -f "$HOME/.zshrc" ]]; then
        mv $HOME/.zshrc $HOME/.zshrc_backup
    fi

    prompt "Install dotfiles" "(cd $HOME/Documents/system_setup && git submodule update --recursive --remote && ./install mac_simple)"
fi

echo "Now set zsh as default shell"
prompt "Set zsh as default shell" "chsh -s $(which zsh)"

prompt "Install oh-my-zsh" "install_ohmyzsh"

echo "All finished"
