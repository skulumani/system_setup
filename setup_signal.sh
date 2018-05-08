
# Download and setup Signal-Cli

SIGNAL_VERSION="0.6.0"
SIGNAL_FNAME="signal-cli-${SIGNAL_VERSION}.tar.gz"
SIGNAL_LINK="https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/${SIGNAL_FNAME}"
SIGNAL_DIR="$HOME/bin/signal-cli"
# test to see if Jabref directory exists in /usr/local

if [[ ! -d "${SIGNAL_DIR}" ]]; then
    echo "Creating ${SIGNAL_DIR}"
    mkdir -p ${SIGNAL_DIR}
else
    echo "${SIGNAL_DIR} already exists"
    echo "Removing old version and creating"
    trash ${SIGNAL_DIR}/*
fi

# Download Jabref to this directory if it doesn't exist
if [ ! -d "${SIGNAL_DIR}/bin" ]; then
    echo "Downloading ${SIGNAL_FNAME}"
    wget ${SIGNAL_LINK} -O /tmp/${SIGNAL_FNAME}
    tar -xzvf /tmp/${SIGNAL_FNAME} -C /tmp/
    mv /tmp/signal-cli-${SIGNAL_VERSION}/bin ${SIGNAL_DIR}
    mv /tmp/signal-cli-${SIGNAL_VERSION}/lib ${SIGNAL_DIR}
else
    echo "${SIGNAL_FNAME} already exists"
fi

# setup links for Jabref icon/menu item
