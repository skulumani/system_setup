#!/bin/sh
REPO="/media/shankar/borg/backup/borgbackup/$(hostname)"
TARGET="seas13009_borg:${REPO}"
# export BORG_PASSPHRASE="password"

source /home/shankar/borg_passphrase.sh

# Compression algorithm and level. See Borg docs.
readonly COMPRESSION_ALGO=zlib
readonly COMPRESSION_LEVEL=6
# Define home directory explicitly, since this script will be run by root.
# (We could also define $HOME in our anacrontab instead.)
readonly HOME=/home/shankar

# Whitespace-separated list of paths to back up.
readonly SOURCE_PATHS="/home/shankar/Documents /home/shankar/Downloads /media/shankar/data/Drive/docs /media/shankar/data/Drive/GWU /home/shankar/Drive"

# Whitespace-separated list of paths to exclude from backup.
readonly EXCLUDE="*.pyc"

# Number of days, weeks, &c. of backups to keep when pruning.
readonly KEEP_DAILY=7
readonly KEEP_WEEKLY=4
readonly KEEP_MONTHLY=6
readonly KEEP_YEARLY=1

# connect using openconnect to vpn
# sudo openconnect -b go.vpn.gwu.edu -u=skulumani 
# echo <password> | sudo openconnect -u <username> --authgroup=<group> -b --passwd-on-stdin <server>
# check if this weeks repo exists, if not then initialize it
if ssh -q seas13009 [ ! -d "${REPO}" ] ; then
    # create a new repository
    borg init --encryption=repokey "${REPO}"
fi

    borg create --v --stats --progress --compression "${COMPRESSION_ALGO},${COMPRESSION_LEVEL}" \
        --exclude "$EXCLUDE" \
        "${TARGET}::{hostname}-{now:%Y-%m-%dT%H:%M:%S}" $SOURCE_PATHS
# create a new archive

# prune the archive
# borg prune --keep-daily="${KEEP_DAILY}" \
#         --keep-weekly="${KEEP_WEEKLY}" \
#         --keep-monthly="${KEEP_MONTHLY}" \
#         --keep-yearly="${KEEP_YEARLY}" \
#         --prefix '{hostname}-' \
#         "${REPO}"

# 

