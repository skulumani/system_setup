#!/bin/bash

# script to install latest version of LaTeX
texlive_year="2019"
texlive_path="/usr/local/texlive/${texlive_year}"
WORK_DIR=$(mktemp -d )

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

if [[ ! -d ${texlive_path} ]]; then
    echo "TexLive ${texlive_year} is not installed"
    prompt "Download texlive installer" "wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O $WORK_DIR/install-tl.tar.gz"
    eval "tar -C $WORK_DIR -xzf $WORK_DIR/install-tl.tar.gz"
    prompt "Create TeXLive directory and set correct permissions" "sudo mkdir -p /usr/local/texlive/$texlive_year; sudo chown -R $USER: /usr/local/texlive/; sudo chmod -R u+rw /usr/local/texlive"
    prompt "Install TeXlive" "$WORK_DIR/install-tl-*/install-tl"
else
    echo "TexLive is already installed"
fi

echo "Now updating TexLive"
# update texlive
tlmgr option -- autobackup 0
tlmgr update --self --all --no-auto-install

echo "Finished updating TexLive"
