
# Download and setup Signal-Cli

SIGNAL_VERSION="0.5.6"
SIGNAL_FNAME="signal-cli-${SIGNAL_VERSION}.tar.gz"
SIGNAL_LINK="https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/${SIGNAL_FNAME}"
SIGNAL_DIR="$HOME/bin/signal-cli"
# test to see if Jabref directory exists in /usr/local

if [[ ! -d "${SIGNAL_DIR}" ]]; then
    echo "Creating ${SIGNAL_DIR}"
    mkdir -p ${SIGNAL_DIR}
else
    echo "${SIGNAL_DIR} already exists"
fi

# Download Jabref to this directory if it doesn't exist
if [ ! -f "${SIGNAL_DIR}/${SIGNAL_FNAME}" ]; then
    echo "Downloading ${SIGNAL_FNAME}"
    wget ${SIGNAL_LINK} ${SIGNAL_DIR}/${SIGNAL_FNAME}
else
    echo "${SIGNAL_FNAME} already exists"
fi

# setup links for Jabref icon/menu item
