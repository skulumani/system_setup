#!/bin/bash

set -e
ZATHURA_VERSION=0.3.9
ZATHURA_SOURCE_URL="https://pwmt.org/projects/zathura/download/zathura-${ZATHURA_VERSION}.tar.xz"
TEMP_DIR="$(mktemp -d)"


# check if the temp dir was created
if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
    echo "Could not create temp dir"
    exit 1
fi

# delete the temp directory on cleanup
function cleanup {
    rm -rf "$TEMP_DIR"
    echo "Deleted temp working directory $TEMP_DIR"
}

# trap cleanup EXIT

echo "Install dependencies"
sudo apt-get remove --purge zathura
sudo apt-get install libgtk-3-dev libgirara-dev libgirara-gtk3-2

read -p "Enter to install Zathura"

# download the source tarball
cd ${TEMP_DIR}
wget ${ZATHURA_SOURCE_URL} $TEMP_DIR
tar xfv zathura-${ZATHURA_VERSION}.tar.xz
cd zathura-${ZATHURA_VERSION}
mkdir build


