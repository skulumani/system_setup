#!/bin/bash

set -e

TMUX_VERSION="2.5"
sudo apt-get remove --purge tmux 
sudo apt-get install cmake libevent-dev libncurses5-dev checkinstall

if [[ ! -d "$HOME/tmux" ]]; then
    git clone https://github.com/tmux/tmux.git ~/tmux
    cd ~/tmux
    git checkout $TMUX_VERSION
else
    cd ~/tmux
    git checkout $TMUX_VERSION
fi

cd ~/tmux
sh autogen.sh
./configure && make
sudo checkinstall
