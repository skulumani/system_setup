#!/bin/bash

TEMPDIR=$(mktemp -d)

# build yubikey and install GPG keys onto device

sudo apt-get -y update

sudo apt-get install -y curl gnupg2 gnupg-agent cryptsetup scdaemon pcscd yubikey-personaliation dirmngr secure-delete

# mac
brew install gnupg yubikey-personalization hopenpgp-tools ykman pinentry-mac

# # yubikey personalization
# sudo apt-get install -y libyubikey-dev pkg-config libusb-1.0-0-dev libjson0-dev
# sudo apt-get install -y autoconf automake libtool

# cd $TEMPDIR
# git clone 
