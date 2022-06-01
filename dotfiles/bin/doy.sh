#!/bin/bash

# DOY script
# Usage: doy yyyy doy - outputs UTC date of input and time until then
# No inputs then just output current date

if [[ $# -eq 0 ]]; then
    echo "Now: $(date "+%Y-%j") -- $(date "+%a %b %d %Y")"
elif [[ $# -ne 1 ]]; then 
    echo "Incorrect number of inputs"
    echo "Usage: doy YYYY-DOY"
    exit 0
elif [[ $# -eq 1 ]]; then
    let DESIRED_DATE=$(date -j -f "%Y-%j" "$1" "+%s")
    let CURRENT_DATE=$(date +%s)
    let DIFF=($DESIRED_DATE - $CURRENT_DATE)/86400

    echo "Now: $(date +%Y)-$(date +%j) -- $(date "+%a %b %d %Y")"
    echo "Desired: $1 -- $(date -j -f "%Y-%j" "$1" "+%a %b %d %Y")"
    echo "Difference: $DIFF days"
fi


    
