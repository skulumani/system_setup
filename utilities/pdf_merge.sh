#!/bin/bash

# get list of files using find/sort
find . -type f -name "*.pdf" | sort -k11 > ./filelist.txt

gs -o output.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress @filelist.txt
