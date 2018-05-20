#!/bin/bash

AG_VERSION=2.1.0
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
trap cleanup EXIT

sudo apt-get -qq update
sudo apt-get remove --purge silversearcher-ag
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev checkinstall

echo "We're going to install the silversearcher-ag from source"

git clone https://github.com/ggreer/the_silver_searcher.git ${WORK_DIR}/ag
cd ${WORK_DIR}/ag
git checkout $AG_VERSION

bash ./build.sh
sudo checkinstall
