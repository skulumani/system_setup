#!/bin/bash
#
# This is a simple wrapper script for the BorgBackup program. It is primarily
# intended for use in cron or anacron jobs but also provides some functions
# that can simplify interactive maintenance of a Borg repository.
#
# The commands in this script assume a compressed, encrypted, remote
# repository, but the script can be modified for other use cases with minimal
# changes.  See the readme for details.

set -o errexit
set -o nounset
set -o pipefail

# Source the repository passphrase from a separate file. That file's ownership
# and permissions should be set to root:root and 600 to prevent exposure of the
# passphrase.
#
# shellcheck disable=SC1091
source /home/shankar/borg_passphrase.sh

# These variables define the path to the Borg repository on the backup machine.
# They can be modified to support local backups if necessary.
#
# Note that the current configuration assumes a one-client-per-repository
# setup, which avoids inefficiencies that can occur when backing up multiple
# machines to a single repository. For details, see
# https://borgbackup.readthedocs.io/en/stable/faq.html#can-i-backup-from-multiple-servers-into-a-single-repository
readonly USER=login
readonly HOST=example.com
readonly REPO="/media/shankar/data/Drive/backup/borgbackup/$(hostname)" # Path to repository on the host
readonly TARGET="${REPO}"
readonly MOUNTPOINT="/tmp/borg_mount"
readonly RCLONE_REMOTE="GWUDrive:/$(hostname)"

# check if it already exists and is empty

# if doesn't exist then create it

# if not empty then create a random directory

# Valid options are "none", "keyfile", and "repokey". See Borg docs.
readonly ENCRYPTION_METHOD=repokey

# Compression algorithm and level. See Borg docs.
readonly COMPRESSION_ALGO=zlib
readonly COMPRESSION_LEVEL=6

# Define home directory explicitly, since this script will be run by root.
# (We could also define $HOME in our anacrontab instead.)
readonly HOME=/home/shankar

# Whitespace-separated list of paths to back up.
readonly SOURCE_PATHS="${HOME}/Documents ${HOME}/Downloads ${HOME}/Drive"

# Whitespace-separated list of paths to exclude from backup.
readonly EXCLUDE="*.pyc"

# Number of days, weeks, &c. of backups to keep when pruning.
readonly KEEP_DAILY=7
readonly KEEP_WEEKLY=4
readonly KEEP_MONTHLY=6
readonly KEEP_YEARLY=1

# $1...: command line arguments
main() {
    if [[ "$#" != 1 ]]; then
        usage
        exit 1
    fi

    parse_args "$@"
    exit 0
}

# $1...: command line arguments
parse_args() {
    while getopts ":ichpdmqluvrb" opt; do
        case $opt in
            i)  init
                exit 0
                ;;
            c)  create
                exit 0
                ;;
            h)  usage
                exit 0
                ;;
            p)  prune
                exit 0
                ;;
            d)  delete
                exit 0
                ;;
            q)  quota
                exit 0
                ;;
            v)  check
                exit 0
                ;;
            l)  list
                exit 0
                ;;
            m)  mount
                exit 0
                ;;
            u)  unmount
                exit 0
                ;;
            r)  rclone_sync
                exit 0
                ;;
            b)  break_lock
                exit 0
                ;;
            :)  printf "Missing argument for option %s\n" "$OPTARG" >&2
                usage
                exit 1
                ;;
            *)  printf "Invalid option: %s\n" "$opt" >&2
                usage
                exit 1
                ;;
        esac
    done
}

usage() {
    printf "REPO : %s\n" "${REPO}"
    printf "BACKUP DIRS : %s\n\n" "${SOURCE_PATHS}"

    printf "Usage: %s OPTION\n" "$(basename "$0")"
    printf "  %s\t%s\n" "-c" "create new archive"
    printf "  %s\t%s\n" "-d" "delete repository"
    printf "  %s\t%s\n" "-h" "print this help text and exit"
    printf "  %s\t%s\n" "-i" "initialize new repository"
    printf "  %s\t%s\n" "-l" "list contents of repository"
    printf "  %s\t%s\n" "-m" "mount the repository"
    printf "  %s\t%s\n" "-p" "prune archive"
    printf "  %s\t%s\n" "-q" "check remote quota usage"
    printf "  %s\t%s\n" "-r" "push repo to GWUDrive using rclone"
    printf "  %s\t%s\n" "-u" "unmount the repository"
    printf "  %s\t%s\n" "-v" "verify repository consistency"
    printf "  %s\t%s\n" "-b" "break lock on repository"
}

init() {
    logger -p user.info "Starting Borg repository initialization: ${TARGET}"

    borg init --remote-path=borg --encryption="${ENCRYPTION_METHOD}" "${TARGET}"

    logger -p user.info "Finished Borg repository initialization ${TARGET}"
}

create() {
    logger -p user.info "Starting Borg archive creation: ${TARGET}"

    # shellcheck disable=SC2086
    # We want $SOURCE_PATHS to undergo word splitting here.
    borg create --remote-path=borg \
        --compression "${COMPRESSION_ALGO},${COMPRESSION_LEVEL}" \
        --exclude "$EXCLUDE" \
        "${TARGET}::{hostname}-{now:%Y-%m-%dT%H:%M:%S}" $SOURCE_PATHS

    logger -p user.info "Finished Borg archive creation: ${TARGET}"
}

prune() {
    logger -p user.info "Starting Borg prune: ${TARGET}"

    borg prune --remote-path=borg \
        --keep-daily="${KEEP_DAILY}" --keep-weekly="${KEEP_WEEKLY}" \
        --keep-monthly="${KEEP_MONTHLY}" --keep-yearly="${KEEP_YEARLY}" \
        "$TARGET"

    logger -p user.info "Finished Borg prune: ${TARGET}"
}

mount () {

    logger -p user.info "Starting Borg mount: ${TARGET} Mount : ${MOUNTPOINT}"
    
    if  [[ ! -d "${MOUNTPOINT}" ]]; then
        mkdir -p ${MOUNTPOINT}
    fi

    borg mount ${TARGET} ${MOUNTPOINT}
    
    printf "Backup mounted at %s" "${MOUNTPOINT}"

    logger -p user.info "Finished Borg mount: ${TARGET} Mount : ${MOUNTPOINT}"
}

unmount () {
    logger -p user.info "Starting Borg unmount: ${TARGET} Mount : ${MOUNTPOINT}"

    borg umount ${MOUNTPOINT}

    logger -p user.info "Finished Borg unmount: ${TARGET} Mount : ${MOUNTPOINT}"
}

delete() {
    printf "Are you sure you want to permanently delete the repository '%s'? [y/N]" "$TARGET"
    read -r response
    if [[ ${response:0:1} != "Y" && ${response:0:1} != "y" ]]; then
        printf "Aborted"
        exit 1
    fi

    # shellcheck disable=SC2029
    # We want the repository name to expand on the client side.
    ssh "${USER}@${HOST}" rm -rf "${REPO}"

    logger -p user.info "Deleted Borg repository: ${TARGET}"
}

rclone_sync() {
    logger -p user.info "Starting rclone push of ${TARGET} to ${RCLONE_REMOTE}"

    rclone sync -v ${REPO} ${RCLONE_REMOTE}

    logger -p user.info "Finished rclone push of ${TARGET} to ${RCLONE_REMOTE}"
}

break_lock() {
    logger -p user.info "Breaking lock on ${REPO}"

    borg break-lock ${REPO}

    logger -p user.info "Finished breaking lock on ${REPO}"

}

quota() {
    # Putting quotes around "quota" prevents spurious Shellcheck warnings.
    ssh "${TARGET}" "quota"
}

check() {
    borg check --remote-path=borg "${TARGET}"
}

list() {
    borg list --remote-path=borg "${TARGET}"
}

on_failure() {
    logger -p user.warning "Borg backup terminated unexpectedly"
}

trap on_failure SIGHUP SIGINT SIGTERM

main "$@"
