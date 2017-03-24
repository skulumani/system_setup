#!/bin/bash

echo "Creating symbolic link for JabRef icon"
ln -s $(pwd)/jabRef.png /opt/jabref/jabRef.png

echo "Creating symbolic link desktop shortcut"
ln -s $(pwd)/JabRef.desktop ~/.local/share/applications/abRef.desktop
echo "JabRef setup is complete"