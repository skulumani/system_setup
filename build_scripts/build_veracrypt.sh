#!/bin/bash

# Links from https://www.veracrypt.fr/en/Downloads.html
# Instrucitons - https://www.veracrypt.fr/en/Digital%20Signatures.html
# SO answer https://askubuntu.com/questions/929195/what-is-the-recommended-way-to-use-veracrypt-in-ubuntu
VERSION="1.23"

GPG_FINGERPRINT="5069A233D55A0EEB174A5FC3821ACD02680D16DE"
GPG_PUBID="0x680D16DE"

SETUP_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-setup.tar.bz2"
SIG_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-setup.tar.bz2.sig"
SUMS_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-sha256sum.txt"

WORK_DIR=$(mktemp -d )

# delete temp dir
cleanup () {
    rm -rf "$WORK_DIR"
    echo "Deleted temp working directory: $WORK_DIR"
}

# register cleanup function to be called on exit
trap cleanup EXIT

command_exists () {
    command -v "$1" >/dev/null 2>&1 ;
}

echo "This will download and verify Veracrypt"

echo "Work Dir: $WORK_DIR"

# download the veracrypt gpg key
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys $GPG_PUBID

# verify the fingerprint
echo "Now we need to verify the fingerprint"

gpg --fingerprint $GPG_PUBID 

echo "Desired fingerprint: $GPG_FINGERPRINT"
read -p "Press enter when matching"
# download the setup file, signature, and shasums

echo "Now we'll download"
read -p "Press Enter to download"

wget $SETUP_URL -P $WORK_DIR
wget $SIG_URL -P $WORK_DIR
wget $SUMS_URL -P $WORK_DIR

# verify the files
cd $WORK_DIR
gpg --verify "veracrypt-$VERSION-sha256sum.txt.sig" "veracrypt-$VERSION-sha256sum.txt"
gpg --verify "veracrypt-$VERSION-setup.tar.bz2.sig" "veracrypt-$VERSION-setup.tar.bz2"

read -p "Press enter if valid verification"

# extract and install

tar xvf "veracrypt-$VERSION-setup.tar.bz2"
read -p "Press enter to start installation"
eval "./veracrypt-$VERSION-setup-gui-x64"
