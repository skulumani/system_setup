# Borg Backup Scripts

This repository contains a handful of scripts that can be used to enable fully
automated encrypted remote backups with [Borg][].

If you're not familiar with Borg, you'll probably want to start by taking
a look at the project's [documentation][Borg docs].

These scripts are not a substitute for a proper understanding of Borg and good
backup practices. You should familiarize yourself with Borg and the contents of
the scripts before using them to perform backups. These scripts have not been
extensively tested; use at your own risk.

## Prerequisites

- You'll need to [install Borg][] on both your local machine and the machine
  where you plan to store your backups.
- The `root` account on your local machine needs passwordless SSH access to
  your remote server.

## Bacic Usage

`backup.sh` is a wrapper around Borg that can perform a number of common
operations:

    Usage: backup.sh OPTION
      -c    create new archive
      -d    delete repository
      -h    print this help text and exit
      -i    initialize new repository
      -l    list contents of repository
      -p    prune archive
      -q    check remote quota usage
      -v    verify repository consistency

The script contains a number of variables that can be used to set the backup
parameters. At the very least, you'll want to modify `USER` and `HOST` to
specify your login and the address of the remote machine, `HOME` to set your
home directory, and `SOURCE_PATHS` and `EXCLUDE` to specify the files to back
up. The other available options are documented in the script.

If you'll be encrypting your backups, you'll also need to create a passphrase
and define it in `borg-passphrase.sh`, which is sourced by `backup.sh`. To
prevent accidental exposure of your passphrase, set the owernship and
permissions on this file to the most restrictive settings possible ( such as
`root:root` and `600`).

The `borg` commands in `backup.sh` all include the option
`--remote-path=borg1`. You will need to remove or modify this to account for
the version of Borg that you're using and the name of the corresponding Borg
script on your remote machine.

To initialize a new repository, run `backup.sh -i`. To perform a backup, run
`backup.sh -c`.

Borg output is set at the default level ("warning") and is output to
stdout and stderr. In addition, the script logs basic information to the
system log.

## [Automation](https://askubuntu.com/questions/2368/how-do-i-set-up-a-cron-job)

You can run `backup.sh` manually, but you'll probably want to automate it using
`cron` or `anacron`. The included `run-backup.sh` script is intended by be run
by a cron job. It creates a new backup, then prunes the existing backups to
conserve space.

A typical `anacrontab` entry to perform daily backups might look something
like this:

    1   5   remote-backup   /home/username/bin/run-backup.sh

### The user `crontab`

1. Copy `borg_local_cron.sh` to `$HOME` and edit paths to backup/source of repo

2. Edit the user crontab using `crontab -e` and add a line:

    ~~~
    minute hour day-of-month month day-of-week command
    ~~~

3. Examples:

    * Every Monday at 17:30

    ~~~
    30 17 * * 1 /path/to/command
    ~~~

    * Every fifteen minutes

    ~~~
    */15 * * * * /path/to/command
    ~~~

    ~~~
    30 */1 * * * export BORG_PASSPHRASE="password"; bash /home/shankar/borg_local_cron.sh 
    ~~~

## Recommendations

You'll probably want to  manually run `backup.sh -v` from time to time to check
the state of the repository, and you should also occasionally perform a backup
restoration to ensure that everything is working properly. (This script does
not cover backup restoration.)

Be sure to make a secure local copy of your passphrase and repository key.

[Borg]: https://github.com/borgbackup/borg
[install Borg]: http://borgbackup.readthedocs.io/en/stable/installation.html
[Borg docs]: https://borgbackup.readthedocs.io/en/stable/
