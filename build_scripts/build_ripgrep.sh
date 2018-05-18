#!/bin/bash

set -e
RG_VERSION=0.8.1
RG_LINK="https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
RG_DIR="$HOME/bin"

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
# download rg
prompt "Download ripgrep binary" "wget ${RG_LINK} -O $WORK_DIR/rg.tar.gz"
mkdir -p $WORK_DIR/rg
eval "tar -C $WORK_DIR/rg -xzf $WORK_DIR/rg.tar.gz --strip-components=1"
prompt "Copy rg v${RG_VERSION} to $HOME/bin" "cp $WORK_DIR/rg/rg $HOME/bin"
echo "Done"

