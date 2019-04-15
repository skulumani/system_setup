#!/bin/bash

# Links from https://www.veracrypt.fr/en/Downloads.html
# Instrucitons - https://www.veracrypt.fr/en/Digital%20Signatures.html

VERSION="1.23"

GPG_FINGERPRINT="5069A233D55A0EEB174A5FC3821ACD02680D16DE"
GPG_PUBID="0x680D16DE"

SETUP_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-setup.tar.bz2"
SIG_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-setup.tar.bz2.sig"
SUMS_URL="https://launchpad.net/veracrypt/trunk/${VERSION}/+download/veracrypt-${VERSION}-sha256sum.txt"

# download the veracrypt gpg key

# verify the fingerprint

# download the setup file, signature, and shasums

# verify the files

# extract and install

tar xvf veracrypt.tar.bz2
./veracrypt*
