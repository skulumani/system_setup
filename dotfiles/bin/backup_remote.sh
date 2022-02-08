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
source ~/borg_passphrase.sh

# These variables define the path to the Borg repository on the backup machine.
# They can be modified to support local backups if necessary.
#
# Note that the current configuration assumes a one-client-per-repository
# setup, which avoids inefficiencies that can occur when backing up multiple
# machines to a single repository. For details, see
# https://borgbackup.readthedocs.io/en/stable/faq.html#can-i-backup-from-multiple-servers-into-a-single-repository
readonly USER=login
readonly HOST="rsync.net"
readonly REPO="borgbackup/$(hostname)" # Path to repository on the host
readonly TARGET="${HOST}:${REPO}"

export BORG_REMOTE_PATH="borg1"

# Valid options are "none", "keyfile", and "repokey". See Borg docs.
readonly ENCRYPTION_METHOD=repokey

# Compression algorithm and level. See Borg docs.
readonly COMPRESSION_ALGO=auto,lzma
readonly COMPRESSION_LEVEL=6

# Define home directory explicitly, since this script will be run by root.
# (We could also define $HOME in our anacrontab instead.)
# readonly HOME=~/

# Whitespace-separated list of paths to back up.
export SOURCE_PATHS="${HOME}/Documents ${HOME}/Downloads"
[ -d "${HOME}/Drive" ] && SOURCE_PATHS+=" ${HOME}/Drive"
[ -d "/media/shankar/data/timelapse" ] && SOURCE_PATHS+=" /media/shankar/data/timelapse"
[ -d "/media/shankar/data/syncthing/docs" ] && SOURCE_PATHS+=" /media/shankar/data/syncthing/docs"

# Whitespace-separated list of paths to exclude from backup.
readonly EXCLUDE="*.pyc"
readonly EXCLUDEFILE="${HOME}/bin/backup_exclude.txt"
# use .nobackup to exclude whole folder

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

# TODO Add borg info command
# $1...: command line arguments
parse_args() {
    while getopts ":ichpdqlvms" opt; do
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
            s)  stats
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
    printf "Usage: %s OPTION\n" "$(basename "$0")"
    printf "  %s\t%s\n" "-c" "create new archive"
    printf "  %s\t%s\n" "-d" "delete repository"
    printf "  %s\t%s\n" "-h" "print this help text and exit"
    printf "  %s\t%s\n" "-i" "initialize new repository"
    printf "  %s\t%s\n" "-l" "list contents of repository"
    printf "  %s\t%s\n" "-m" "mount repo to temp directory"
    printf "  %s\t%s\n" "-p" "prune archive"
    printf "  %s\t%s\n" "-q" "check remote quota usage"
    printf "  %s\t%s\n" "-s" "show repo stats"
    printf "  %s\t%s\n" "-v" "verify repository consistency"
}

init() {
    logger -p user.info "Starting Borg repository initialization: ${TARGET}"

    borg init --encryption="${ENCRYPTION_METHOD}" "${TARGET}"

    logger -p user.info "Finished Borg repository initialization ${TARGET}"
}

create() {
    logger -p user.info "Starting Borg archive creation: ${TARGET}"

    # shellcheck disable=SC2086
    # We want $SOURCE_PATHS to undergo word splitting here.
    borg create \
        --compression "${COMPRESSION_ALGO},${COMPRESSION_LEVEL}" \
        --exclude "$EXCLUDE" --exclude-from ${EXCLUDEFILE} --exclude-if-present ".nobackup" \
        --progress --stats \
        "${TARGET}::{hostname}-{now:%Y-%m-%dT%H:%M:%S}" $SOURCE_PATHS

    # borg check "${TARGET}"

    logger -p user.info "Finished Borg archive creation: ${TARGET}"

}

prune() {
    logger -p user.info "Starting Borg prune: ${TARGET}"

    borg prune \
        --keep-daily="${KEEP_DAILY}" --keep-weekly="${KEEP_WEEKLY}" \
        --keep-monthly="${KEEP_MONTHLY}" --keep-yearly="${KEEP_YEARLY}" \
        "$TARGET"

    logger -p user.info "Finished Borg prune: ${TARGET}"
}

# delete() {
#     printf "Are you sure you want to permanently delete the repository '%s'? [y/N]" "$TARGET"
#     read -r response
#     if [[ ${response:0:1} != "Y" && ${response:0:1} != "y" ]]; then
#         printf "Aborted"
#         exit 1
#     fi

#     # shellcheck disable=SC2029
#     # We want the repository name to expand on the client side.
#     ssh "${USER}@${HOST}" rm -rf "${REPO}"

#     logger -p user.info "Deleted Borg repository: ${TARGET}"
# }

quota() {
    # Putting quotes around "quota" prevents spurious Shellcheck warnings.
    ssh "${HOST}" "quota"
}

check() {
    # borg check "${TARGET}"
    borg check --verify-data "${TARGET}"
}

list() {
    borg list "${TARGET}"
}

stats() {
    borg info "${TARGET}"
}

mount() {
    MNT_DIR=$(mktemp -d -t borg-XXXXXX)
    echo "Repo: ${MNT_DIR}"
    echo "Ctrl-C to kill and unmount"

    borg mount --foreground "${TARGET}" $MNT_DIR
}

on_failure() {
    logger -p user.warning "Borg backup terminated unexpectedly"
}

trap on_failure SIGHUP SIGINT SIGTERM

main "$@"
