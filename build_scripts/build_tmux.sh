#!/bin/bash

set -e

TMUX_VERSION="2.7"
TMUX_DIR="/tmp/tmux"

sudo apt-get remove --purge tmux 
sudo apt-get install automake autotools-dev cmake libevent-dev libncurses5-dev checkinstall pkg-config

if [[ ! -d ${TMUX_DIR} ]]; then
    git clone https://github.com/tmux/tmux.git ${TMUX_DIR}
    cd ${TMUX_DIR}
    git checkout $TMUX_VERSION
fi

cd ${TMUX_DIR}
sh autogen.sh
./configure && make
sudo checkinstall
