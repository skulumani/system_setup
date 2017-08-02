#!/bin/sh
REPO="/media/shankar/borg/backup/borgbackup/seas13009"

# export BORG_PASSPHRASE="password"

# Compression algorithm and level. See Borg docs.
readonly COMPRESSION_ALGO=zlib
readonly COMPRESSION_LEVEL=6
# Define home directory explicitly, since this script will be run by root.
# (We could also define $HOME in our anacrontab instead.)
readonly HOME=/home/shankar

# Whitespace-separated list of paths to back up.
readonly SOURCE_PATHS="${HOME}/Documents ${HOME}/Downloads /media/shankar/data/Drive/docs /media/shankar/data/Drive/GWU"

# Whitespace-separated list of paths to exclude from backup.
readonly EXCLUDE="*.pyc"

# Number of days, weeks, &c. of backups to keep when pruning.
readonly KEEP_DAILY=7
readonly KEEP_WEEKLY=4
readonly KEEP_MONTHLY=6
readonly KEEP_YEARLY=1

# create a new archive

borg create --v --stats --progress --compression "${COMPRESSION_ALGO},${COMPRESSION_LEVEL}" \
    --exclude "$EXCLUDE" \
    "${REPO}::{hostname}-{now:%Y-%m-%dT%H:%M:%S}" $SOURCE_PATHS

# prune the archive
borg prune --keep-daily="${KEEP_DAILY}" \
        --keep-weekly="${KEEP_WEEKLY}" \
        --keep-monthly="${KEEP_MONTHLY}" \
        --keep-yearly="${KEEP_YEARLY}" \
        --prefix '{hostname}-' \
        "${REPO}"

# 

