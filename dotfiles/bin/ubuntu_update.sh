#!/bin/bash

sudo apt update && sudo apt list --upgradable && sudo apt full-upgrade && sudo apt autoremove && flatpak update

sudo apt update 
sudo apt list --upgradable
sudo apt full-upgrade
sudo apt autoremove
flatpak update

