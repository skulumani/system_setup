#!/bin/bash
BORG_VERSION=1.1.9
BORG_PATH="https://github.com/borgbackup/borg/releases/download/${BORG_VERSION}/borg-linux64"
BORG_SIG="https://github.com/borgbackup/borg/releases/download/${BORG_VERSION}/borg-linux64.asc"

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

echo "This will download the Borg $BORG_VERSION binary to ~/bin"

# install borg from repo if desired
# sudo add-apt-repository ppa:costamagnagianfranco/borgbackup
# sudo apt-get update
# sudo apt-get install borgbackup

# check if borg already exists
if command_exists borg; then
    echo "Borg already installed"
    echo "This will copy version $BORG_VERSION over it"
    borg --version
    wget $BORG_PATH -P $WORK_DIR
    wget $BORG_SIG -P $WORK_DIR
else
    echo "Borg not installed"
    wget $BORG_PATH -P $WORK_DIR
    wget $BORG_SIG -P $WORK_DIR
fi

echo $WORK_DIR
# import the gpg key for Borg signing
echo "Now we'll get Borg GPG key"
gpg --recv-keys "6D5B EF9A DD20 7580 5747 B70F 9F88 FB52 FAF7 B393" 

cd $WORK_DIR

echo " "
echo " "
echo "Now verifying the signature"

gpg --verify borg-linux64.asc

read -p "Press Enter if Signature is Good"

# move to the bin directory
cp borg-linux64 ~/bin/borg
# chown root:root ~/bin/borg
chmod 755 ~/bin/borg

# now setup borg passphrase
echo " "
echo "Now you'll need to update ~/borg_passphrase.sh with the password from Bitwarden"
cp $HOME/Documents/system_setup/dotfiles/borg-backup-scripts/borg_passphrase.sh ~/borg_passphrase.sh

read -p "Press Enter when complete"
chmod 400 ~/borg_passphrase.sh

