#!/bin/bash

set -e
AG_VERSION=2.1.0
sudo apt-get remove --purge silversearcher-ag
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev checkinstall

echo "We're going to install the silversearcher-ag from source"

if [[ ! -d "$HOME/ag" ]]; then
    git clone https://github.com/ggreer/the_silver_searcher.git ~/ag
    cd ~/ag
    git checkout $AG_VERSION
else
    cd ~/ag
    git checkout $AG_VERSION
fi

cd ~/ag
bash ./build.sh
sudo checkinstall
