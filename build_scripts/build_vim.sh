#!/bin/bash

VIM_VERSION="v8.1.0010"
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

trap cleanup EXIT

sudo apt-get remove --purge vim \
    vim-gtk \
    vim-runtime \
    vim-gnome \
    vim-tiny \
    vim-common \
    vim-gui-common

sudo apt-get install liblua5.1-dev \
    lua5.1 \
    luajit \
    libluajit-5.1 \
    python-dev \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python3-dev \
    ruby \
    ruby-dev \
    libruby \
    libperl-dev \
    git \
    checkinstall \
    vim-runtime


echo "We're going to clone and checkout Vim from github"

git clone https://github.com/vim/vim.git ${WORK_DIR}/vim
cd ${WORK_DIR}/vim
git checkout $VIM_VERSION

if [[ ! -d "$HOME/anaconda3/envs/neovim3" ]]; then
    echo "Install neovim3 environment using conda"
    exit 1
fi

if [[ ! -d "$HOME/anaconda3/envs/neovim2" ]]; then
    echo "install neovim2 environemtn using conda"
    exit 1
fi

./configure --with-features=huge \
            --enable-multibyte \
            --enable-pearlinterp=yes \
            --enable-luainterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=$HOME/anaconda3/envs/neovim2/lib/python2.7/config \
            --enable-python3interp \
            --with-python3-config-dir=$HOME/anaconda3/envs/neovim3/lib/python3.6/config-3.6m-x86_64-linux-gnu \
            --with-luajit \
            --with-x \
            --enable-gui=auto \
            --enable-fail-if-missing \
            --enable-cscope \
            --enable-largefile \
            --enable-netbeans \
            --enable-fontset \
            --with-compiledby="Shankar Kulumani" \
            --prefix=/usr/local

make
sudo checkinstall

# # sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
