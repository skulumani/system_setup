#!/bin/sh

set -e

sudo apt-get remove --purge vim \
    vim-gtk \
    vim-runtime \
    vim-gnome \
    vim-tiny \
    vim-common \
    vim-gui-common

sudo apt-get install liblua5.1-dev \
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
    git

cd ~
git clone https://github.com/vim/vim.git
cd vim

./configure --with-features=huge \
            --enable-multibyte \
            --enable-largefile \
            --enable-netbeans \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-gui=auto \
            --enable-fail-if-missing \
            --enable-cscope \
            --prefix=/usr 2>config_err.log >config.log || cat config_err.log
make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo apt-get install checkinstall
cd ~/vim
sudo checkinstall
# sudo make install
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
