## BorgBackup Instructions - [Client to Remote Repo](https://borgbackup.readthedocs.io/en/stable/deployment.html)

1. Install BorgBackup from repo

~~~
sudo apt-get install borgbackup
~~~

2. Create a new `borgbackup` user on the remote ssh server

~~~
useradd borgbackup -m
~~~

3. Copy client ssh keys to the server under `borgbackup`

~~~
ssh-copy-id borgbackup@host.net
~~~

4. Create a directory for the borg repo and give permissions to `borgbackup`

~~~
setfacl -m u:borgbackup:x /rather
setfacl -m u:borgbackup:x /rather/long
setfacl -m u:borgbackup:x /rather/long/path
setfacl -m u:borgbackup:x /rather/long/path/to
setfacl -m u:borgbackup:x /rather/long/path/to/the
setfacl -m u:borgbackup:xr /rather/long/path/to/the/directory
~~~

5. Setup restricted ssh-commands when clients connect to this user by modifying `/home/borgbackup/.ssh/authorized_keys`

~~~
command="cd /borgbackup/directory;borg serve --restrict-to-path /borgbackup/directory",no-port-forwarding,no-X11-forwarding,no-pty,no-agent-forwarding,no-user-rc ssh-rsa <KEY COPIED OVER> shanks.k@gmail.com
~~~

6. Now backup using borg on the client computer to the remote using ssh

* [Quickstart](https://borgbackup.readthedocs.io/en/stable/quickstart.html)

~~~
borg init user@host.net:/path/to/repo
borg create user@host.net:/path/to/repo::Archive_Name ~/src ~/Drive
~~~

## fstab mounting on Ubunutu

[Documentation](https://help.ubuntu.com/community/Fstab)

1. Create the mount point somewhere, i.e. `sudo mkdir /media/shankar/mount_point`
2. Find UUID - `ls -la /dev/disk/by-uuid` and looking for the UUID which matched the mount point of the drive from `mount`
3. Unmount the drive if mounted already
4. Edit fstab to add a line like the following
~~~
/dev/disk/by-uuid/UUID /media/shankar/mount_point auto nosuid,nodev,nofail,x-gvfs-show 0 0
~~~
5. Remount by running - `sudo mount -a `

