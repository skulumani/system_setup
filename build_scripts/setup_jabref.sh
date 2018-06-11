# Download and setup JabRef into ~/

JABREF_VERSION="4.3.1"
JABREF_FNAME="JabRef-${JABREF_VERSION}.jar"
JABREF_LINK="https://github.com/JabRef/jabref/releases/download/v${JABREF_VERSION}/${JABREF_FNAME}"
JABREF_DIR="$HOME/bin/JabRef"
# test to see if Jabref directory exists in /usr/local

if [[ ! -d "${JABREF_DIR}" ]]; then
    echo "Creating ${JABREF_DIR}"
    mkdir -p ${JABREF_DIR}
else
    echo "${JABREF_DIR} already exists"
fi

# Download Jabref to this directory if it doesn't exist
if [ ! -f "${JABREF_DIR}/${JABREF_FNAME}" ]; then
    echo "Downloading ${JABREF_FNAME}"
    wget ${JABREF_LINK} -O ${JABREF_DIR}/${JABREF_FNAME}
else
    echo "${JABREF_FNAME} already exists"
fi

# setup links for Jabref icon/menu item

# should be setup by the dotfiles installer
