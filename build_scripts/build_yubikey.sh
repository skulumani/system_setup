#!/bin/bash

TEMPDIR=$(mktemp -d)
GNUPGHOME=$(mktemp -d)
RUNDIR=$(pwd)

# make sure tmp dir was actually created
if [[ ! -d "$TEMPDIR" ]]; then
    echo "Could not create temp directory"
    exit 1
fi

# delete temp dir
cleanup () {
    rm -rf "$TEMPDIR"
    echo "Deleted temp working directory: $TEMPDIR"
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
# build yubikey and install GPG keys onto device

# sudo apt-get -y update

# sudo apt-get install -y curl gnupg2 gnupg-agent cryptsetup scdaemon pcscd yubikey-personaliation dirmngr secure-delete

# mac
brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac

# # yubikey personalization
# sudo apt-get install -y libyubikey-dev pkg-config libusb-1.0-0-dev libjson0-dev
# sudo apt-get install -y autoconf automake libtool

# cd $TEMPDIR
# git clone 

# generate a master key
cp $RUNDIR/../dotfiles/gpg.conf $GNUPGHOME/gpg.conf
echo "Select (4) RSA (sign only) and 4096"
gpg --full-generate-key


