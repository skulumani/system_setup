#!/bin/bash

echo "Creating symbolic link for JabRef icon"
ln -s $(pwd)/jabRef.png /opt/jabref/jabRef.png

echo "Creating symbolic link desktop shortcut"
ln -s $(pwd)/jabRef.desktop ~/.local/share/applications/jabRef.desktop

echo "JabRef setup is complete"