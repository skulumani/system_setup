#!/bin/sh

DIR="/media/shankar/borg/backup/borgbackup"
REPO="seas13009"
DATE="$(date +%Y-%m-%dT%H:%M:%S)"
NEWNAME="${DATE}_${REPO}"

# Number of days, weeks, &c. of backups to keep when pruning.
readonly KEEP_HOURLY=6
readonly KEEP_DAILY=7
readonly KEEP_WEEKLY=4
readonly KEEP_MONTHLY=6
readonly KEEP_YEARLY=1
newline=$'\n'
# export BORG_PASSPHRASE="passphrase"
source /home/shankar/borg_passphrase.sh

# push the repo to Google drive
cd ${DIR}

# prune the archive
{
borg check "${DIR}/${REPO}"

# push borg repo to google drive
drive push --no-prompt ${REPO}
# rename the remote directory to a new name with current date
drive rename -local=false -remote=true ${REPO} ${NEWNAME}

/usr/bin/borg prune --keep-hourly="${KEEP_HOURLY}" --keep-daily="${KEEP_DAILY}" \
        --keep-weekly="${KEEP_WEEKLY}" \
        --keep-monthly="${KEEP_MONTHLY}" \
        --keep-yearly="${KEEP_YEARLY}" \
        --prefix '{hostname}-' --verbose --stats \
        "${DIR}/${REPO}"

echo "SUCCESS $(date +%Y-%m-%dT%H:%M:%S)${newline}SEAS13009 drive push" | /home/shankar/bin/signal-cli/bin/signal-cli -u +16305579049 send "+16303366257"

} || {

echo "FAILURE $(date +%Y-%m-%dT%H:%M:%S)${newline}SEAS13009 drive push" | /home/shankar/bin/signal-cli/bin/signal-cli -u +16305579049 send "+16303366257"
}

