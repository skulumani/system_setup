## New computer setup

* Setup SSH Keys for Github
* Run `bash linux_setup.sh` or `bash mac_setup.sh`

    * [Anaconda Hashes](https://docs.anaconda.com/anaconda/install/hashes/)

## Apps to install

* Steam - software center
* Discord - software center
* gnome-disks - software center
* Drive
* Borg backup - run `bash build_scripts/build_borg.sh`
* Veracrypt
* Build Essentials and Cmake
* Set up fstab mounting for data drive to `/media/shankar/data` with gnome-disks
* Setup conky autostart
* Setup crontab for automatic borg backups to local and remote
* Signal Desktop - `bash build_scripts/build_signal_desktop.sh`
* rclone - run `bash build_scripts/build_rclone.sh` then follow [Drive](https://rclone.org/drive/)

## Backups

Create `~/borg_passphrase.sh` with the following variables

~~~
export BORG_PASSPHRASE=<>
export RESTIC_PASSWORD=<>
export B2_ACCOUNT_ID=<>
export B2_ACCOUNT_KEY=<>
~~~

In the past, `borg` was used but now moving to `restic`. 
It is attached in Bitwarden Backblaze credentials.

### Mac specifics

* Install the fonts located in `dotfiles/.fonts` by just clicking on them
* change the login shell by going to Settings > Users > Right Click User and go to Advanced > Change shell
* Install dotfiles a few times to make sure it's all working
* Swap Caps lock and escape - Settings > Keyboard > Modifier Keys

## Dot files

Can install profiles:

~~~
bash install_profile.sh <ubuntu or mac or rpi>
~~~

Or install standalone items using:

~~~
bash install_standalone.sh <vim or tmux or etc>
~~~

Profiles: `dotfiles/meta/profiles`

Configs: `dotfiles/meta/configs`

### TMUX Plugins
The plugin manager `tpm` lives inside `.tmux/plugins/tpm`. 
This manager will automatically clone any other plugins into the appropriate location.

To add a plugin, add the following to the bottom of `.tmux.conf`
~~~
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'
~~~

From within `tmux` then just run `prefix + r` to reload the configuration file, followed by
`prefix + I` (`Ctrl-A then Shift I`)

To uninstall a plugin `prefix + alt + u`
To update plugins `prefix + U`

### Vim plugins

Just run `:PluginInstall` a few times and be happy

## [GPG setup](./gpg.md)

## Xfce setup

For the time use this `%a %b %e %Y %T`

## Jekyll for website development

* Install [RVM(https://rvm.io/)]
~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm install ruby-2.3.0-dev
~~~
* Install bundler
~~~
gem install bundler execjs therubyracer
~~~
* Clone repo and navigate to the directory
~~~
bundle install
bundle update
~~~
* Create website
~~~
bundle exec jekyll serve
~~~

## Mounting an external drive

Create a mount point - sudo mkdir /media/data

Change ownership sudo chown pi:users /media/data

Mount sudo mount /dev/sda /media/data

Edit fstab

UUID=<UUID> /<mount point> auto defaults,user,nofail 0 0 

Get UUID - sudo blkid

Add execute bit recursively sudo chmod u+x -R /media/data

# Wireguard VPN

https://github.com/adrianmihalko/raspberrypiwireguard
https://github.com/adrianmihalko/raspberrypiwireguard/issues/13

## Conky

~~~
conky --config=/home/shankar/.config/conky/conky_stats.conf
~~~

Use gnome-tweaks for gnome or Session and Startup for XFCE
