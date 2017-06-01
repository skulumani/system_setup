#!/bin/bash

set -e

sudo apt-get remove --purge tmux 
sudo apt-get install cmake libevent-dev libncurses5-dev

if [[ ! -d "$HOME/vim" ]]; then
    git clone https://github.com/tmux/tmux.git 
fi

cd ~/tmux
sh autogen.sh
./configure && make
sudo make install
