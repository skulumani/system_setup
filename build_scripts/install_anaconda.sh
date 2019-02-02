#!/usr/bin/env bash
# trap functions to delete temporary folder on exit
# find directory of script
DIR="$HOME"

# create a temp directory inside $DIR
WORK_DIR=$(mktemp -d -p "$DIR")

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

# register cleanup function to be called on exit
trap cleanup EXIT

# anaconda version
miniconda_latest_linux_64_hash="866ae9dff53ad0874e1d1a60b1ad1ef8"
miniconda_latest_armv71_hash="a01cbe45755d576c2bb9833859cf9fd7"
miniconda_latest_mac_hash="a583d1e174e1dc960e87fb4b026a9370"

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

command_exists () {
    command -v "$1" >/dev/null 2>&1 ;
}

check_md5 () {
    md5sum -c <<< "$1 $2";
}

# install anaconda
if [[ ! -d "$HOME/anaconda3" ]]; then
    echo "Anaconda is not installed"

    echo "Now will check for machine type"
    if [[ "$(uname -m)" == "armv7l" ]]; then
        echo "On an arm device"
        prompt "Download Miniconda for ARM?" "wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh -O ${WORK_DIR}/miniconda.sh"
        if ! md5sum -c <<< "$miniconda_latest_armv71_hash ${WORK_DIR}/miniconda.sh"; then
            echo "Hash doesn't match Aborting!"
            exit 1
        else
            echo "Hash match. installing minconda"
            prompt "Install Miniconda" "bash ${WORK_DIR}/miniconda.sh -b -p $HOME/anaconda3"
        fi
    elif [[ "$(uname -m)" == "x86_64" ]]; then
        echo "On an x86_64 linux device"
        prompt "Download Miniconda for x86_64 Linux?" "wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ${WORK_DIR}/miniconda.sh"
        if ! md5sum -c <<< "$miniconda_latest_linux_64_hash ${WORK_DIR}/miniconda.sh"; then
            echo "Hash doesn't match Aborting!"
            exit 1
        else
            echo "Hash match. installing minconda"
            prompt "Install Miniconda" "bash ${WORK_DIR}/miniconda.sh -b -p $HOME/anaconda3"
        fi
    else
        echo "No machine match"
    fi


else
    echo "Anaconda is already installed"
fi
