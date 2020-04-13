# Download and setup JabRef into ~/

JABREF_VERSION="5.1"
JABREF_FNAME="JabRef-${JABREF_VERSION}-portable_linux.tar.gz"
JABREF_LINK="https://builds.jabref.org/master/${JABREF_FNAME}"
JABREF_DIR="$HOME/JabRef"

WORK_DIR=$(mktemp -d)

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

# trap cleanup EXIT
# test to see if Jabref directory exists

if [[ ! -d "${JABREF_DIR}" ]]; then
    echo "Creating ${JABREF_DIR}"
    mkdir -p ${JABREF_DIR}
else
    echo "${JABREF_DIR} already exists"
fi

echo "Downloading ${JABREF_FNAME}"
wget ${JABREF_LINK} -O ${WORK_DIR}/${JABREF_FNAME}

# untar it 
cd $WORK_DIR
tar -xvzf ${JABREF_FNAME}
mv ./JabRef/bin ${JABREF_DIR}
mv ./JabRef/lib ${JABREF_DIR}
# echo "Install Oracle  JAVA"
# sudo add-apt-repository ppa:webupd8team/java
# sudo apt-get update
# sudo apt-get install oracle-java8-installer

# setup links for Jabref icon/menu item

# should be setup by the dotfiles installer
