#!/bin/bash

set -e

echo "We're going to install fzf fuzzy file finder"

if [[ ! -d "$HOME/fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
else
    cd ~/fzf
    git checkout master
    git pull
    ./install
fi
