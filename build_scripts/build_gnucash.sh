#!/bin/bash

# Script to download and build GnuCash from source
VERSION=3.4
BUILD=""
TEMP_DIR="$(mktemp -d)"
URL=https://github.com/Gnucash/gnucash/releases/download/$VERSION/gnucash-$VERSION.tar.bz2
SHASUM=a254883c8f7e34f2e19ebdc6a0185489d9027341d7d62a6f1ef815a8c9e342d7

echo "This will download and install the GnuCash ${VERSION}${BUILD}"
echo "First we'll remove gnucash"

read -p "Press Enter to continue"

sudo apt-get purge gnucash
sudo apt-get install checkinstall webkit2gtk-4.0 webkit2gtk-3.0
sudo apt-get build-dep gnucash 

echo "Now going to download gnucash v$VERSION$BUILD"

read -p "Press Enter to continue"

if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
	echo "Could not create temp dir"
	exit 1
fi

cd ${TEMP_DIR}
wget $URL

if ! sha256sum -c <<< "$SHASUM gnucash-$VERSION.tar.bz2"; then
    echo "Hash does not match. Aborting!"
    exit 1
else
    echo "Hash match. Installing GnuCash"
fi

mkdir gnucash
tar -xjvf gnucash-$VERSION.tar.bz2 --strip-components=1 -C ./gnucash

echo "Now build gnucash"
read -p "Press Enter to continue"

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../gnucash
make -j 4
# TODO Look up checkinstall flags to make this automatic
# sudo checkinstall make install
echo $TEMP_DIR
