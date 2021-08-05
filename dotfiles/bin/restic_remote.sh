#!/bin/bash
#
# This is a simple wrapper script for the restic program. It is primarily
# intended for use in cron or anacron jobs but also provides some functions
# that can simplify interactive maintenance of a restic repository.
#
# It is primiarly setup to push changes to remote B2 bucket.
#
# The commands in this script assume a compressed, encrypted, remote
# repository, but the script can be modified for other use cases with minimal
# changes.  See the readme for details.

# Example - https://github.com/alphapapa/restic-runner#verify-randomly-n
set -o errexit
set -o nounset
set -o pipefail

# Source the repository passphrase from a separate file. That file's ownership
# and permissions should be set to root:root and 600 to prevent exposure of the
# passphrase.
#
# shellcheck disable=SC1091
source ~/borg_passphrase.sh

# Path to Backblaze repo
export RESTIC_REPOSITORY="b2:spellbind-rigid-strongman:/restic/backup"

export EXCLUDE_FILE="${HOME}/bin/restic_excludes.txt"

# Whitespace-separated list of paths to back up.
export SOURCE_PATHS="${HOME}/Documents ${HOME}/Downloads ${HOME}/Drive"

# Number of days, weeks, &c. of backups to keep when pruning. Use --host option
export KEEP_LAST=3 # keep the last n most recent snapshots
export KEEP_HOURLY=6
export KEEP_DAILY=7
export KEEP_WEEKLY=4
export KEEP_MONTHLY=6
export KEEP_YEARLY=1
export KEEP_DURATION="5y0m0d0h" # keep all snapshots in the last X years from latest snapshot

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
    while getopts ":bcfhilpms" opt; do
        case $opt in
            i)  init
                exit 0
                ;;
            b)  backup
                exit 0
                ;;
            h)  usage
                exit 0
                ;;
            p)  prune
                exit 0
                ;;
            c)  check
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
    printf "  %s\t%s\n" "-b" "backup data to a new snapshot"
    printf "  %s\t%s\n" "-c" "check repository consistency"
    printf "  %s\t%s\n" "-h" "print this help text and exit"
    printf "  %s\t%s\n" "-i" "initialize new repository"
    printf "  %s\t%s\n" "-l" "list contents of repository"
    printf "  %s\t%s\n" "-p" "prune and remove snapshots according to policy"
    printf "  %s\t%s\n" "-m" "mount latest snapshot"
    printf "  %s\t%s\n" "-s" "print repo stats"
    printf "  %s\t%s\n" "-v" "verify data by downloading and checking - expensive"
}

init() {
    logger -p user.info "Starting restic repository initialization: ${RESTIC_REPOSITORY}"
    
    restic init

    logger -p user.info "Finished restic repository initialization ${RESTIC_REPOSITORY}"
}

backup() {
    logger -p user.info "Starting restic snapshot: ${RESTIC_REPOSITORY}"

    # shellcheck disable=SC2086
    # We want $SOURCE_PATHS to undergo word splitting here.
    restic --verbose=1 --exclude-file=${EXCLUDE_FILE} --exclude-if-present=".nobackup" backup $SOURCE_PATHS

    # now check 
    restic --verbose check

    logger -p user.info "Finished restic snapshot: ${RESTIC_REPOSITORY}"
}

# TODO Split prune and forget operations
prune() {
    logger -p user.info "Starting restic prune: ${RESTIC_REPOSITORY}"

    restic forget --prune --dry-run --host \
        --keep-last=${KEEP_LAST} \
        --keep-hourly=${KEEP_HOURLY} \
        --keep-daily=${KEEP_DAILY} \
        --keep-weekly=${KEEP_WEEKLY} \
        --keep-monthly=${KEEP_MONTHLY} \
        --keep-yearly=${KEEP_YEARLY} \
        --keep-within=${KEEP_DURATION}

    logger -p user.info "Finished restic prune: ${RESTIC_REPOSITORY}"
}

quota() {
    # Putting quotes around "quota" prevents spurious Shellcheck warnings.
    ssh "${TARGET}" "quota"
}

stats() {
    restic stats --mode restore-size latest
    restic stats --mode raw-data # total size for all snapshots (close)
    # restic stats --mode files-by-contents
    # restic stats --mode blobs-per-file
}

check() {
    restic check --verbose 
    # restic check --verbose --read-data-subset=5% # need to update restic for this
}

list() {
    restic snapshots
}

mount () {
    # make a tmp directory
    MNT_DIR=$(mktemp -d -t restic-XXXXXX)

    echo "Repo: ${MNT_DIR}"
    restic mount $MNT_DIR

    # unmount
}

# TODO Add snapshot diff command - take two snapshot ids as input

on_failure() {
    logger -p user.warning "restic backup terminated unexpectedly"
}

trap on_failure SIGHUP SIGINT SIGTERM

main "$@"
