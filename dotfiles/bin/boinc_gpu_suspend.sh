#!/bin/bash

boinccmd --set_gpu_mode auto

gdbus monitor --session --dest org.gnome.SessionManager --object-path /org/gnome/SessionManager/Presence | 
while read -r sig; do
    case $sig in
        *StatusChanged*3,\)) boinccmd --set_gpu_mode always;;
        *StatusChanged*) boinccmd --set_gpu_mode auto;;
    esac;
done
