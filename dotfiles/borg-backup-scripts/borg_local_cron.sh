#!/bin/bash
set -e 
set -x
HOSTNAME=$(hostname)
REPO="/media/shankar/data/Drive/backup/borgbackup/${HOSTNAME}"

# export BORG_PASSPHRASE="passphrase"
source /home/shankar/borg_passphrase.sh

# Compression algorithm and level. See Borg docs.
readonly COMPRESSION_ALGO=zlib
readonly COMPRESSION_LEVEL=6
# Define home directory explicitly, since this script will be run by root.
# (We could also define $HOME in our anacrontab instead.)
readonly HOME=/home/shankar

# Whitespace-separated list of paths to back up.
readonly SOURCE_PATHS="/home/shankar/Documents /home/shankar/Downloads /home/shankar/Drive"

# Whitespace-separated list of paths to exclude from backup.
readonly EXCLUDE="*.pyc"

# Number of days, weeks, &c. of backups to keep when pruning.
readonly KEEP_HOURLY=6
readonly KEEP_DAILY=7
readonly KEEP_WEEKLY=4
readonly KEEP_MONTHLY=6
readonly KEEP_YEARLY=1

newline=$'\n'
# create a new archive
{
if [ ! -d "${REPO}" ]; then
    # create a new repository
    /usr/bin/borg init --encryption=repokey "${REPO}"
fi

BORG_MESSAGE=$((/usr/bin/borg create --verbose --stats --compression "${COMPRESSION_ALGO},${COMPRESSION_LEVEL}" \
    --exclude "$EXCLUDE" \
    "${REPO}::{hostname}-{now:%Y-%m-%dT%H:%M:%S}" $SOURCE_PATHS) 2>&1)

# # prune the archive
# /usr/bin/borg prune --keep-hourly="${KEEP_HOURLY}" --keep-daily="${KEEP_DAILY}" \
#         --keep-weekly="${KEEP_WEEKLY}" \
#         --keep-monthly="${KEEP_MONTHLY}" \
#         --keep-yearly="${KEEP_YEARLY}" \
#         --prefix '{hostname}-' --verbose --stats \
#         "${REPO}"

SIGNAL_MESSAGE="SUCCESS $(date +%Y-%m-%dT%H:%M:%S) ${HOSTNAME}${newline}${BORG_MESSAGE}"
# echo "SUCCESS $(date +%Y-%m-%dT%H:%M:%S)${newline}${HOSTNAME} ${MSG}" | /opt/signal-cli/bin/signal-cli --dbus-system send "+16303366257"

} || {

SIGNAL_MESSAGE="FAILURE $(date +%Y-%m-%dT%H:%M:%S) ${HOSTNAME}${newline}${BORG_MESSAGE}"
# echo "FAILURE $(date +%Y-%m-%dT%H:%M:%S)${newline}${HOSTNAME} ${MSG}" | /opt/signal-cli/bin/signal-cli --dbus-system send "+16303366257"
}

dbus-send --system --type=method_call --print-reply --dest="org.asamk.Signal" /org/asamk/Signal org.asamk.Signal.sendMessage string:"${SIGNAL_MESSAGE}" array:string: string:"+16303366257"
 

