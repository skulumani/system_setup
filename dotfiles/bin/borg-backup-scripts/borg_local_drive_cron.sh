#!/bin/sh

REPO="/media/shankar/borg/backup/borgbackup"
# push the repo to Google drive
cd ${REPO}

# push borg repo to google drive
drive push --no-prompt seas13009
# rename the remote directory to a new name with current date
drive rename -local=false -remote=true seas13009 $NEWNAME
