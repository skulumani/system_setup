#!/bin/bash
set -e
# Build neovim
NEOVIM_VERSION="v0.2.0"
# install prereqs
sudo apt-get update
sudo apt-get install libtool libtool-bin autoconf automake cmake \
    g++ pkg-config unzip libc6-dev libiconv-hook1 libiconv-hook-dev
# uninstall neovim if installed
sudo apt-get remove --purge neovim

# check if neovim already exists
if [[ -d "$HOME/neovim" ]]; then
    rm -rIv $HOME/neovim
fi

# clone neovim
if [[ ! -d "$HOME/neovim_source" ]]; then
    git clone https://github.com/neovim/neovim.git ~/neovim_source
    cd ~/neovim_source
    git checkout $NEOVIM_VERSION
else
    cd ~/neovim_source
    git checkout $NEOVIM_VERSION
fi

cd ~/neovim_source
# build
if [[ -d "build" ]]; then
    rm -rIv build
fi

make CMAKE_BUILD_TYPE=Release \
    CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install



