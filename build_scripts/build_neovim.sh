#!/bin/bash
# Build neovim
NEOVIM_VERSION="v0.3.0"
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
prompt "Uninstall neovim?" "sudo apt-get remove --purge neovim || sudo rm /usr/local/bin/nvim || sudo rm -r /usr/local/share/nvim"

# clone neovim
prompt "Clone neovim and install?" "git clone https://github.com/neovim/neovim.git $WORK_DIR/neovim"
cd $WORK_DIR/neovim
git checkout $NEOVIM_VERSION

make CMAKE_BUILD_TYPE=Release
sudo make install

# NEOVIM_VERSION="0.3.0"
# NEOVIM_FNAME="nvim.appimage"
# NEOVIM_LINK="https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/${NEOVIM_FNAME}"
# NEOVIM_DIR="$HOME/bin/neovim"
# # test to see if Jabref directory exists in /usr/local

# if [[ ! -d "${NEOVIM_DIR}" ]]; then
#     echo "Creating ${NEOVIM_DIR}"
#     mkdir -p ${NEOVIM_DIR}
# else
#     echo "${NEOVIM_DIR} already exists"
# fi

# # Download Jabref to this directory if it doesn't exist
# # if [ ! -f "${NEOVIM_DIR}/${NEOVIM_FNAME}" ]; then
#     echo "Downloading ${NEOVIM_FNAME}"
#     wget ${NEOVIM_LINK} -O ${NEOVIM_DIR}/nvim
#     chmod +x ${NEOVIM_DIR}/nvim
# # fi




