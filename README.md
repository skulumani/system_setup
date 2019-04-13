## New computer setup

* Run `bash linux_setup.sh` or `bash mac_setup.sh`

    * [Anaconda Hashes](https://docs.anaconda.com/anaconda/install/hashes/)

## Apps to install

* Steam - software center
* Discord - software center
* gnome-disks - software center
* Drive
* Borg backup - run `bash build_scripts/build_borg.sh`
* Kmymoney - software center
* Veracrypt
* Build Essentials and Cmake
* Set up fstab mounting for data drive to `/media/shankar/data` with gnome-disks
* Setup conky autostart
* Setup crontab for automatic borg backups to local and remote
* rclone - software center

### Mac specifics

* Install the fonts located in `dotfiles/.fonts` by just clicking on them
* change the login shell by going to Settings > Users > Right Click User and go to Advanced > Change shell
* Install dotfiles a few times to make sure it's all working
* Swap Caps lock and escape - Settings > Keyboard > Modifier Keys

## Dot files

After cloning the system setup repo, make sure it's up to date and run `./dotfiles/install linux` or `./dotfiles/install mac`

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

### `ctag` help

Run `:MakeTags` inside vim to generate all the tags for the current directory.
Then use one of the following:
* `Ctrl-]` to jump to tag under cursor
* `g-Ctrl-]` for ambiguous tag
* `Ctrl-t` to jump back up the tag stack

### Autocomplete for vim

Just type `Ctrl-n` for autocomplete then `Ctrl-n` or `Ctrl-p` to go forward and backward.

You can autocomplete filenames using `Ctrl-x` then `Ctrl-f`.

Look at `:help ins-completion` for extra help.


## `font` installation
* [Source Code Pro version](https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro%2F1.050R-it)

All the fonts are in the `~/.fonts` directory which is installed by `dotbot`

## [GPG setup](./gpg.md)

* Import GPG key from Lastpass into the system key store
~~~
gpg --import public.key
gpg --allow-secret-key-import --import private.key
~~~

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

## Building Vim

Some useful links 

* [YouCompleteMe Instructions](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source)
* [Github Gist](https://gist.github.com/Mistobaan/b1384a44e8b5a8b35c6e1c7a4c546e84)
* [Building Vim](https://www.xorpd.net/blog/vim_python3_install.html)

You should be able to simply run `./build_vim.sh`

Also depending on the options, you might need to install an Anaconda environment first.

## FSTAB for GWU shared drives

In order to add the shared drives to Linux

Add the following to `/etc/fstab`

~~~
//titan.seas.gwu.edu/Homes/skulumani /media/titan_drive/ cifs username=USERNAME_HERE,password=PASSWORD_HERE,domain=seas.gwu.edu,_netdev,iocharset=utf8,sec=ntlmv2,users 0 0
~~~

## Dual monitors on xfce

After setting up the nvidia drivers and connecting both monitors you can move the default panel to the chosen monitor by going to

~~~
Settings Mangaer > Panel > Output dropdown > Select Monitor
~~~

## Mounting an external drive

Create a mount point - sudo mkdir /media/data

Change ownership sudo chown pi:users /media/data

Mount sudo mount /dev/sda /media/data

Edit fstab

UUID=<UUID> /<mount point> auto defaults,user,nofail 0 0 

Get UUID - sudo blkid

Add execute bit recursively sudo chmod u+x -R /media/data

