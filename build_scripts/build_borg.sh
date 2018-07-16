#!/bin/bash
BORG_VERSION=1.1.6

# import the gpg key for Borg signing

# download the binary and key from github

# move to the bin directory

# setup the borg PPA

# install borg
sudo add-apt-repository ppa:costamagnagianfranco/borgbackup
sudo apt-get update
sudo apt-get install borgbackup

