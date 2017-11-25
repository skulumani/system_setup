# Download and setup JabRef into ~/

JABREF_VERSION="4.0"
JABREF_FNAME="JabRef-$(JABREF_VERSION).jar"
JABREF_LINK="https://github.com/JabRef/jabref/releases/download/v$(JABREF_VERSION)/$(JABREF_FNAME)"
JABREF_DIR="/usr/local/JabRef"
# test to see if Jabref directory exists in /usr/local

if [[ ! -d "$(JABREF_DIR)" ]]; then
    echo "Creating /usr/local/JabRef"
    mkdir -p $(JABREF_DIR)
else
    echo "/usr/local/JabRef already exists"
fi

# Download Jabref to this directory if it doesn't exist

# setup links for Jabref icon/menu item

