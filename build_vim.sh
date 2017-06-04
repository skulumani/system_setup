#!/bin/bash

set -e

VIM_VERSION="v8.0.0606"

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
    ruby-dev \
    libperl-dev \
    git \
    checkinstall

echo "We're going to clone and checkout Vim from github"

if [[ ! -d "$HOME/vim" ]]; then
    git clone https://github.com/vim/vim.git ~/vim
else
    cd ~/vim
    git checkout $VIM_VERSION
fi

cd ~/vim

if [[ ! -d "$HOME/anaconda3/envs/neovim2" ]]; then
    echo "Install neovim2 environment using conda"
else
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-largefile \
                --enable-netbeans \
                --enable-pythoninterp=yes \
                --with-python-config-dir=$HOME/anaconda3/envs/neovim2/lib/python2.7/config \
                --enable-gui=auto \
                --enable-fail-if-missing \
                --enable-cscope \
                --enable-pearlinterp=yes \
                --enable-luainterp=yes \
                --prefix=/usr 2>config_err.log >config.log || cat config_err.log
fi
make VIMRUNTIMEDIR=/usr/share/vim/vim80

cd ~/vim
sudo checkinstall
# sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
