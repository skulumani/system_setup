#!/bin/bash
# Build neovim
NEOVIM_VERSION="nightly"
WORK_DIR=$(mktemp -d)

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

# register cleanup function to be called on exit
# trap cleanup EXIT
# install prereqs
prompt "Run apt-get update?" "sudo apt-get -qq update"
prompt "Install dependencies?" "sudo apt-get install ninja-build libtool libtool-bin autoconf automake cmake g++ pkg-config unzip texinfo"

# uninstall neovim if installed
prompt "Uninstall neovim?" "sudo apt-get remove --purge neovim && sudo rm /usr/local/bin/nvim && sudo rm -r /usr/local/share/nvim"

# clone neovim
prompt "Clone neovim and install?" "git clone https://github.com/neovim/neovim.git $WORK_DIR/neovim"
cd $WORK_DIR/neovim
git checkout $NEOVIM_VERSION

make 
sudo make install




