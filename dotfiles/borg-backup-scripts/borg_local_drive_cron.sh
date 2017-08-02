#!/bin/sh

DIR="/media/shankar/borg/backup/borgbackup"
REPO="seas13009"
DATE="$(date +%Y-%m-%dT%H:%M:%S)"
NEWNAME="${DATE}_${REPO}"

# push the repo to Google drive
cd ${DIR}

# push borg repo to google drive
drive push --no-prompt ${REPO}
# rename the remote directory to a new name with current date
drive rename -local=false -remote=true ${REPO} ${NEWNAME}
